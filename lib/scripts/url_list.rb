module Barchart
  module BarchartUrls
    extend self

    def barchart_urls
      urls = {}

      url = <<~HEREDOC.gsub(/^[\s\t]*|[\s\t]*\n/, '').strip
      https://core-api.barchart.com/v1/quotes/get?lists=stocks.highslows.current.
      highs.1m.us&fields=symbol%2CsymbolName%2ClastPrice%2CpriceChange%2CpercentChange%
      2Cvolume%2ChighHits1m%2ChighPercent1m%2ClowPercent1m%2CtradeTime%2CsymbolCode%
      2CsymbolType%2ChasOptions&meta=field.shortName%2Cfield.type%2Cfield.description
      &hasOptions=true&raw=1
      HEREDOC

      urls[:one_month_high] = url

      url = <<~HEREDOC.gsub(/^[\s\t]*|[\s\t]*\n/, '').strip
      https://core-api.barchart.com/v1/quotes/get?lists=stocks.highslows.current.
      lows.1m.us&fields=symbol%2CsymbolName%2ClastPrice%2CpriceChange%2CpercentChange%
      2Cvolume%2ChighHits1m%2ChighPercent1m%2ClowPercent1m%2CtradeTime%2CsymbolCode%
      2CsymbolType%2ChasOptions&meta=field.shortName%2Cfield.type%2Cfield.description
      &hasOptions=true&raw=1
      HEREDOC

      urls[:one_month_low] = url

      url = <<~HEREDOC.gsub(/^[\s\t]*|[\s\t]*\n/, '').strip
      https://core-api.barchart.com/v1/quotes/get?lists=stocks.highslows.current.
      highs.3m.us&fields=symbol%2CsymbolName%2ClastPrice%2CpriceChange%2CpercentChange%
      2Cvolume%2ChighHits1m%2ChighPercent1m%2ClowPercent1m%2CtradeTime%2CsymbolCode%
      2CsymbolType%2ChasOptions&meta=field.shortName%2Cfield.type%2Cfield.description
      &hasOptions=true&raw=1
      HEREDOC

      urls[:three_month_high] = url

      url = <<~HEREDOC.gsub(/^[\s\t]*|[\s\t]*\n/, '').strip
      https://core-api.barchart.com/v1/quotes/get?lists=stocks.highslows.current.
      lows.3m.us&fields=symbol%2CsymbolName%2ClastPrice%2CpriceChange%2CpercentChange%
      2Cvolume%2ChighHits1m%2ChighPercent1m%2ClowPercent1m%2CtradeTime%2CsymbolCode%
      2CsymbolType%2ChasOptions&meta=field.shortName%2Cfield.type%2Cfield.description
      &hasOptions=true&raw=1
      HEREDOC

      urls[:three_month_low] = url

      url = <<~HEREDOC.gsub(/^[\s\t]*|[\s\t]*\n/, '').strip
      https://core-api.barchart.com/v1/quotes/get?lists=stocks.highslows.current.
      highs.6m.us&fields=symbol%2CsymbolName%2ClastPrice%2CpriceChange%2CpercentChange%
      2Cvolume%2ChighHits1m%2ChighPercent1m%2ClowPercent1m%2CtradeTime%2CsymbolCode%
      2CsymbolType%2ChasOptions&meta=field.shortName%2Cfield.type%2Cfield.description
      &hasOptions=true&raw=1
      HEREDOC

      urls[:six_month_high] = url

      url = <<~HEREDOC.gsub(/^[\s\t]*|[\s\t]*\n/, '').strip
      https://core-api.barchart.com/v1/quotes/get?lists=stocks.highslows.current.
      lows.6m.us&fields=symbol%2CsymbolName%2ClastPrice%2CpriceChange%2CpercentChange%
      2Cvolume%2ChighHits1m%2ChighPercent1m%2ClowPercent1m%2CtradeTime%2CsymbolCode%
      2CsymbolType%2ChasOptions&meta=field.shortName%2Cfield.type%2Cfield.description
      &hasOptions=true&raw=1
      HEREDOC

      urls[:six_month_low] = url

      url = <<~HEREDOC.gsub(/^[\s\t]*|[\s\t]*\n/, '').strip
      https://core-api.barchart.com/v1/quotes/get?lists=stocks.highslows
      .current.highs.1y.us&fields=symbol%2CsymbolName%2ClastPrice%2CpriceChange
      %2CpercentChange%2Cvolume%2ClowHits1y%2ChighPercent1y%2ClowPercent1y%2CtradeTime
      %2CsymbolCode%2CsymbolType%2ChasOptions&meta=field.shortName%2Cfield.type%2Cfield
      .description&hasOptions=true&raw=1
      HEREDOC

      urls[:fifty_two_week_high] = url

      url = <<~HEREDOC.gsub(/^[\s\t]*|[\s\t]*\n/, '').strip
      https://core-api.barchart.com/v1/quotes/get?lists=stocks.highslows
      .current.lows.1y.us&fields=symbol%2CsymbolName%2ClastPrice%2CpriceChange
      %2CpercentChange%2Cvolume%2ClowHits1y%2ChighPercent1y%2ClowPercent1y%2CtradeTime
      %2CsymbolCode%2CsymbolType%2ChasOptions&meta=field.shortName%2Cfield.type%2Cfield
      .description&hasOptions=true&raw=1
      HEREDOC

      urls[:fifty_two_week_low] = url

      url = <<~HEREDOC.gsub(/^[\s\t]*|[\s\t]*\n/, '').strip
      https://core-api.barchart.com/v1/quotes/get?lists=stocks.highslows.current.
      highs.alltime.us&fields=symbol%2CsymbolName%2ClastPrice%2CpriceChange%2CpercentChange
      %2ChighPrice%2ClowPrice%2Cvolume%2CtradeTime%2CsymbolCode%2CsymbolType%2ChasOptions
      &meta=field.shortName%2Cfield.type%2Cfield.description&hasOptions=true&raw=1
      HEREDOC

      urls[:all_time_high] = url


      url = <<~HEREDOC.gsub(/^[\s\t]*|[\s\t]*\n/, '').strip
      https://core-api.barchart.com/v1/quotes/get?lists=stocks.highslows.current.
      lows.alltime.us&fields=symbol%2CsymbolName%2ClastPrice%2CpriceChange%2CpercentChange
      %2ChighPrice%2ClowPrice%2Cvolume%2CtradeTime%2CsymbolCode%2CsymbolType%2ChasOptions
      &meta=field.shortName%2Cfield.type%2Cfield.description&hasOptions=true&raw=1
      HEREDOC

      urls[:all_time_low] = url

      url = <<~HEREDOC.gsub(/^[\s\t]*|[\s\t]*\n/, '').strip
      https://core-api.barchart.com/v1/quotes/get?lists=stocks.highslows.current.
      highs.ytd.us&fields=symbol%2CsymbolName%2ClastPrice%2CpriceChange%2CpercentChange%
      2Cvolume%2ChighHits1m%2ChighPercent1m%2ClowPercent1m%2CtradeTime%2CsymbolCode%
      2CsymbolType%2ChasOptions&meta=field.shortName%2Cfield.type%2Cfield.description
      &hasOptions=true&raw=1
      HEREDOC

      urls[:year_to_date_high] = url

      url = <<~HEREDOC.gsub(/^[\s\t]*|[\s\t]*\n/, '').strip
      https://core-api.barchart.com/v1/quotes/get?lists=stocks.highslows.current.
      lows.ytd.us&fields=symbol%2CsymbolName%2ClastPrice%2CpriceChange%2CpercentChange%
      2Cvolume%2ChighHits1m%2ChighPercent1m%2ClowPercent1m%2CtradeTime%2CsymbolCode%
      2CsymbolType%2ChasOptions&meta=field.shortName%2Cfield.type%2Cfield.description
      &hasOptions=true&raw=1
      HEREDOC

      urls[:year_to_date_low] = url

      urls
    end
  end
end
