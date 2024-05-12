# frozen_string_literal: true

class ASTMMessage
  attr_accessor :header, :patient, :orders, :results, :terminator

  def initialize(astm_string = nil)
    @header = {}
    @patient = {}
    @orders = []
    @results = []
    @terminator = {}

    parse(astm_string) if astm_string
  end

  def parse(astm_string)
    segments = astm_string.split("\r")
    segments.each do |segment|
      fields = segment.split('|')
      case fields[0]
      when 'H'
        parse_header(fields)
      when 'P'
        parse_patient(fields)
      when 'O'
        @orders << parse_order(fields)
      when 'R'
        @results << parse_result(fields)
      when 'L'
        parse_terminator(fields)
      end
    end
  end

  def parse_header(fields)
    @header = {
      sender: fields[4],
      receiver: fields[9],
      date_time: fields[13]
    }
  end

  def parse_patient(fields)
    @patient = {
      id: fields[2],
      additional_info: fields[3..-1]
    }
  end

  def parse_order(fields)
    { order_id: fields[2], test_code: fields[4] }
  end

  def parse_result(fields)
    { test_id: fields[2], value: fields[3], unit: fields[4] }
  end

  def parse_terminator(fields)
    @terminator = { code: fields[1] }
  end

  def to_astm
    [
      "H|\\^&||#{@header[:sender]}|||||#{@header[:receiver]}||P|#{@header[:date_time]}|",
      "P|#{@patient[:id]}|#{@patient[:additional_info].join('|')}|",
      @orders.map { |o| "O|#{o[:order_id]}||#{o[:test_code]}|||||||N||||^O|||" }.join("\r"),
      @results.map { |r| "R|#{r[:test_id]}|#{r[:value]}|#{r[:unit]}||||F|||" }.join("\r"),
      "L|#{@terminator[:code]}|N"
    ].join("\r")
  end
end

