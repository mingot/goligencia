import re
from scrapy.contrib.spiders import CrawlSpider, Rule
from scrapy.contrib.linkextractors.sgml import SgmlLinkExtractor
from scrapy.selector import HtmlXPathSelector
from scrapy.contrib.loader import XPathItemLoader

from marca.items import MatchItem

def make_list():
    list =[]
    years_list = ["2012_13", "2011_12", "2010_11", "2009_10", "2008_09", 
                    "2007_08", "2006_07", "2005_06", "2004_05", "2003_04", 
                    "2002_03", "2001_02", "2000_01"] 
                    
    base_url = "http://www.marca.com/estadisticas/futbol/primera/"
    days = range(1,39)
    for year in years_list:
        for day in days:
            # print(base_url + year + "/jornada_" + str(day))
            list.append(base_url + year + "/jornada_" + str(day))
    return list

class MatchSpider(CrawlSpider):
    name = 'match_spider'

    # start_urls = [
    #   #"http://127.0.0.1:8000/",
    #   "http://www.marca.com/estadisticas/futbol/primera/2012_13/",
      # "http://www.marca.com/estadisticas/futbol/primera/2011_12/jornada_1/",
      # "http://www.marca.com/estadisticas/futbol/primera/2009_10/jornada_8/atletico_mallorca/",
      # "http://www.marca.com/estadisticas/futbol/primera/2002_03/jornada_2/",
      # "http://www.marca.com/estadisticas/futbol/primera/2000_01/jornada_1/",
      # "http://www.marca.com/estadisticas/futbol/primera/2011_12/jornada_8/",
    # ]
    start_urls = make_list()



    rules = (
        Rule(SgmlLinkExtractor(
            restrict_xpaths=('//td[@class="resultado"]', )), 
            callback='parse_item'
            ),
    )   


    def parse_item(self, response):
        self.log('Hi, this is an item page! %s' % response.url)

        hxs = HtmlXPathSelector(response)
        # temporada = hxs.select('//small/text()').extract()[0][10:17]

        l = XPathItemLoader(item=MatchItem(), response=response)
    
        l.add_xpath('team1','//descendant::h5[1]/a/text()')
        l.add_xpath('team2','//descendant::h5[2]/a/text()')
        l.add_xpath('day','//h3/text()')
        l.add_xpath('season','//small/text()')
        l.add_xpath('result1','//h4[@class="res-local"]/text()')
        l.add_xpath('result2','//h4[@class="res-visitante"]/text()')
        
        for i in range(1,9):
            try:
                title = hxs.select('/descendant::th['+str(i)+']/text()').extract()[0]
            except IndexError:
                print('just 7 sections')
            else:
                title = hxs.select('/descendant::th['+str(i)+']/text()').extract()[0]
                title = re.sub(' \(\d+\)','',title) #clean the numbers at the end
                if title == u'Posesi\xf3n':
                    l.add_xpath('posesion1', '/descendant::td[@class="local"]['+str(i)+']/span/text()')
                elif title == u'Remates a puerta':
                    l.add_xpath('rematesPuerta1', '/descendant::td[@class="local"]['+str(i)+']/span/text()')
                    l.add_xpath('rematesPuerta2', '/descendant::td[@class="visitante"]['+str(i)+']/span/text()')
                elif title == u'Remates entre los 3 palos':
                    l.add_xpath('rematesEntreTresPalos1', '/descendant::td[@class="local"]['+str(i)+']/span/text()')
                    l.add_xpath('rematesEntreTresPalos2', '/descendant::td[@class="visitante"]['+str(i)+']/span/text()')   
                elif title == u'Corners':
                    l.add_xpath('corners1', '/descendant::td[@class="local"]['+str(i)+']/span/text()')
                    l.add_xpath('corners2', '/descendant::td[@class="visitante"]['+str(i)+']/span/text()')    
                elif title == u'Intervenciones portero':
                    l.add_xpath('intervencionesPortero1', '/descendant::td[@class="local"]['+str(i)+']/span/text()')
                    l.add_xpath('intervencionesPortero2', '/descendant::td[@class="visitante"]['+str(i)+']/span/text()')    
                elif title == u'Balones perdidos':
                    l.add_xpath('balonesPerdidos1', '/descendant::td[@class="local"]['+str(i)+']/span/text()')
                    l.add_xpath('balonesPerdidos2', '/descendant::td[@class="visitante"]['+str(i)+']/span/text()')
                elif title == u'Balones recuperados':
                    l.add_xpath('balonesRecuperados1', '/descendant::td[@class="local"]['+str(i)+']/span/text()')
                    l.add_xpath('balonesRecuperados2', '/descendant::td[@class="visitante"]['+str(i)+']/span/text()')
                elif title == u'Faltas cometidas':
                    l.add_xpath('faltasCometidas1', '/descendant::td[@class="local"]['+str(i)+']/span/text()')
                    l.add_xpath('faltasCometidas2', '/descendant::td[@class="visitante"]['+str(i)+']/span/text()')
        
        l.add_xpath('faltasSancionadas1','/descendant::dd[2]/text()')
        l.add_xpath('faltasSancionadas2','/descendant::dd[3]/text()')
        l.add_xpath('fuerasDeJuego1','/descendant::dd[5]/text()')
        l.add_xpath('fuerasDeJuego2','/descendant::dd[6]/text()')
        l.add_xpath('penalties1','/descendant::dd[8]/text()')
        l.add_xpath('penalties2','/descendant::dd[9]/text()')
        l.add_xpath('targetasAmarilas1','/descendant::dd[11]/text()')
        l.add_xpath('targetasAmarilas2','/descendant::dd[12]/text()')
        l.add_xpath('targetasRojas1','/descendant::dd[14]/text()')
        l.add_xpath('targetasRojas2','/descendant::dd[15]/text()')


        return l.load_item()