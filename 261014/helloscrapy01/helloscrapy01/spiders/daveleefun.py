import scrapy
from helloscrapy01.items import Helloscrapy01Item


class DaveleefunSpider(scrapy.Spider):
    name = "daveleefun"
    allowed_domains = ["davelee-fun.github.io"]
    start_urls = ["https://davelee-fun.github.io"]

    def parse(self, response):
        item = Helloscrapy01Item()
        item["title"] = response.css('h1.sitetitle::text').get()
        # 1) 예외조항처리 기법 : 코드가 길어지는 단점, strip() 대상이 존재하지 않을 것까지 예상한 안전, 보수 코드 
        if description :
            item["description"] = description.strip()
        else :
            item["description"] = ""
        # description = response.xpath('//p[@class="lead"]/text()').get()
        # item["description"] = response.xpath('//p[@class="lead"]/text()').get().strip() # .strip : Method Chaning 기법(누락이 있을 경우 에러가 나옴 그래서 코드 분산하기)

        yield item