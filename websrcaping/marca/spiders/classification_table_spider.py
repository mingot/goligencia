from scrapy.spider import BaseSpider
from scrapy.selector import HtmlXPathSelector
from scrapy.contrib.loader import XPathItemLoader

from marca.items import TeamItem 



def make_list():
	list =[]
	years_list = ["2012_13", "2011_12", "2010_11", "2009_10", "2008_09", "2007_08", "2006_07", "2005_06", "2004_05", "2003_04", "2002_03", "2001_02", "2000_01"] 
	base_url = "http://www.marca.com/estadisticas/futbol/primera/"
	days = range(1,39)
	for year in years_list:
		for day in days:
			# print(base_url + year + "/jornada_" + str(day))
			list.append(base_url + year + "/jornada_" + str(day))
	return list


class ClassificationTableSpider(BaseSpider):
	name = "classification_table_spider"
	allowed_domains = ["marca.com"]
	# start_urls = [
	# 	#"http://127.0.0.1:8000/",
	# 	"http://www.marca.com/estadisticas/futbol/primera/2012_13/",
	# 	"http://www.marca.com/estadisticas/futbol/primera/2011_12/jornada_1/",
	# 	"http://www.marca.com/estadisticas/futbol/primera/2002_03/jornada_2/",
	# ]
	start_urls = make_list()

	def parse(self, response):
		hxs = HtmlXPathSelector(response)
		teams = hxs.select('//tbody/tr') #get the table rows
		season = hxs.select('//small/text()').extract()
		day = hxs.select('//h3/text()').extract()
		items = []
		for index,team in enumerate(teams):
			l = XPathItemLoader(item=TeamItem(), response=response, selector=team)
			l.add_xpath('name', 'td[@class="equipo"]/text()')
			l.add_xpath('name', 'td[@class="equipo"]/a/text()')
			l.add_value('season',season)
			l.add_value('day',day)
			l.add_value('position', str(index+1))
			l.add_xpath('pj','td[@class="pj"]/text()')
			l.add_xpath('pg','td[@class="pg"]/text()')
			l.add_xpath('pe','td[@class="pe"]/text()')
			l.add_xpath('pp','td[@class="pp"]/text()')
			l.add_xpath('gf','td[@class="gf"]/text()')
			l.add_xpath('gc','td[@class="gc"]/text()')
			l.add_xpath('points','td[@class="pts seleccionado"]/text()')
			items.append(l.load_item())
		return items





