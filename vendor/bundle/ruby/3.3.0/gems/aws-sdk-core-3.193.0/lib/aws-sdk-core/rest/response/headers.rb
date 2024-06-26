# frozen_string_literal: true

require 'time'
require 'base64'
require_relative 'header_list_parser'

module Aws
  module Rest
    module Response
      class Headers

        include Seahorse::Model::Shapes

        # @param [Seahorse::Model::ShapeRef] rules
        def initialize(rules)
          @rules = rules
        end

        # @param [Seahorse::Client::Http::Response] http_resp
        # @param [Hash, Struct] target
        def apply(http_resp, target)
          headers = http_resp.headers
          @rules.shape.members.each do |name, ref|
            case ref.location
            when 'header' then extract_header_value(headers, name, ref, target)
            when 'headers' then extract_header_map(headers, name, ref, target)
            end
          end
        end

        def extract_header_value(headers, name, ref, data)
          if headers.key?(ref.location_name)
            data[name] = cast_value(ref, headers[ref.location_name])
          end
        end

        def cast_value(ref, value)
          value = extract_json_trait(value) if ref['jsonvalue']
          case ref.shape
          when StringShape then value.to_s
          when IntegerShape then value.to_i
          when FloatShape then Util.deserialize_number(value)
          when BooleanShape then value == 'true'
          when ListShape then
            case ref.shape.member.shape
            when StringShape then HeaderListParser.parse_string_list(value)
            when TimestampShape then HeaderListParser.parse_timestamp_list(value, ref.shape.member)
            else value.split(', ').map { |v| cast_value(ref.shape.member, v) }
            end
          when TimestampShape
            if value =~ /^\d+(\.\d*)/
              Time.at(value.to_f)
            elsif value =~ /^\d+$/
              Time.at(value.to_i)
            else
              begin
                Time.parse(value)
              rescue
                nil
              end
            end
          else raise "unsupported shape #{ref.shape.class}"
          end
        end

        def extract_header_map(headers, name, ref, data)
          data[name] = {}
          prefix = ref.location_name || ''
          headers.each do |header_name, header_value|
            if match = header_name.match(/^#{prefix}(.+)/i)
              data[name][match[1]] = header_value
            end
          end
        end

        def extract_json_trait(value)
          Aws::Json.load(Base64.decode64(value))
        end

      end
    end
  end
end
