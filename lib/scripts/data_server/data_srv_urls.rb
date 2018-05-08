module DataServer
  module DataServerUrls
    extend self

    def data_server_urls
      urls = {
        nyse:   'http://datasrv.ddfplus.com/names/nyse.txt',
        nasdaq: 'http://datasrv.ddfplus.com/names/nasd.txt',
        amex: 'http://datasrv.ddfplus.com/names/amex.txt'
      }
    end
  end
end
