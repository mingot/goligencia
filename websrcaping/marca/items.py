# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

from scrapy.item import Item, Field

class TeamItem(Item):
	name = Field()
	season = Field()
	day = Field()
	position = Field()
	pj = Field()
	pg = Field()
	pe = Field()
	pp = Field()
	gf = Field()
	gc = Field()
	points = Field()

class MatchItem(Item):
	team1 = Field()
	team2 = Field()
	day = Field()
	season = Field()
	result1 = Field()
	result2 = Field()
	posesion1 = Field()
	
	rematesPuerta1 = Field()
	rematesPuerta2 = Field()
	corners1 = Field()
	corners2 = Field()
	intervencionesPortero1 = Field()
	intervencionesPortero2 = Field()
	balonesPerdidos1 = Field()
	balonesPerdidos2 = Field()
	balonesRecuperados1 = Field()
	balonesRecuperados2 = Field()
	faltasCometidas1 = Field()
	faltasCometidas2 = Field()

	rematesEntreTresPalos1 = Field()
	rematesEntreTresPalos2 = Field()

	faltasSancionadas1 = Field()
	faltasSancionadas2 = Field()
	fuerasDeJuego1 = Field()
	fuerasDeJuego2 = Field()
	penalties1 = Field()
	penalties2 = Field()
	targetasAmarilas1 = Field()
	targetasAmarilas2 = Field()
	targetasRojas1 = Field()
	targetasRojas2 = Field()
