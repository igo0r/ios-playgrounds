//
//  Article.swift
//  tableCell
//
//  Created by Igor Lantushenko on 27/01/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import UIKit


class Article: NSObject {
    var title : String = ""
    var image : UIImage = UIImage()
    var text : String = ""
    
    override init (){
        
    }
    
    func getNews() -> [Article] {
        var result = [Article]()

        var article = Article()
        article.title = "For decades after she died, at just 24"
        article.text = "According to her death certificate, Lehnkering, who once dreamed of working in a nursery, died of peritonitis. But she didn't really, she was gassed, one of tens of thousands of people killed by the Nazis during their \"Aktion T4\" project.        The project targeted disabled and ill people, considered by the Nazis as unworthy, and killed about 70,000 at six sites in German-controlled territory between January 1940 and August 1941."
        article.image = UIImage(named: "1")!
        result.append(article)
        
        article = Article()
        article.title = "The little girl who captured the world's heart tweeting about her life"
        article.text = "Bana Alabed shared a short video of herself and the Mean Girls star, apparently shot in Turkey. Ms Lohan, who has been in the country for the past few days, says in the video that the pair are \"sending lots of love and life and blessings\" to refugees and people in Syria."
        article.image = UIImage(named: "2")!
        result.append(article)
        
        article = Article()
        article.title = "Free soda: France bans unlimited sugary drink refills"
        article.text = "It is now illegal to sell unlimited soft drinks at a fixed price or offer them unlimited for free. The number of overweight or obese people in France is below the EU average but is on the rise. The World Health Organization (WHO) recommends taxing sugary drinks, linking them to obesity and diabetes. Self-service \"soda fountains\" have long been a feature of family restaurants and cafes in some countries like the UK, where a soft drinks tax will be introduced next year."
        article.image = UIImage(named: "3")!
        result.append(article)
        
        article = Article()
        article.title = "US anti-abortion activists rally in DC"
        article.text = "Organisers expected thousands of people to join the event, held each year to mark the anniversary of the Supreme Court decision legalising abortion. Vice-President Mike Pence told them: \"Life is winning again in America\". It comes less than a week after a large protest against Mr Trump was held in the nation's capital city. An estimated 500,000 people protested for women's rights last Saturday - including many supporters of abortion rights - at the Women's March."
        article.image = UIImage(named: "4")!
        result.append(article)
        
        article = Article()
        article.title = "Uncovering the secrets of North America's largest diamond"
        article.text = "Africa is home to the world’s largest diamonds - but advances in mining technology are enabling other regions of the world to get in on the act. Most recently, Canada unearthed the biggest diamond ever found in North America - the Foxfire. It has spent the last couple of months on display at the Smithsonian’s National Museum of Natural History in Washington."
        article.image = UIImage(named: "5")!
        result.append(article)
        
        article = Article()
        article.title = "Sanctions on table ahead of US-Putin call"
        article.text = "The two world leaders are expected to discuss bilateral affairs and national security in the first call since Mr Trump's inauguration. Mr Trump has also hinted at lifting some of the US sanctions on Russia. But Republicans have expressed opposition to any softer White House line against Moscow. Senator John McCain, who says Mr Putin is a thug, said that would be a \"reckless course\" and he would pursue legislation to enforce the sanctions."
        article.image = UIImage(named: "6")!
        result.append(article)
        
        article = Article()
        article.title = "Francois Fillon: I will drop out of France president race if investigated"
        article.text = "Mr Fillon is at the centre of a media storm over allegations that for years his wife was paid for parliamentary work she did not do. The conservative candidate told French TV there was nothing improper or illegal about his wife's employment. He said he would provide proof but he refused to be tried by the media."
        article.image = UIImage(named: "7")!
        result.append(article)
        
        article = Article()
        article.title = "Former VW boss investigated over emissions fraud"
        article.text = "Martin Winterkorn quit in September 2015 after VW admitted to using software to lower the emissions from its diesel vehicles during tests. He has since denied knowing of the violations until late in August 2015, shortly before the board reported them. But German authorities said they were now investigating him for fraud. Prosecutors from the German region of Braunschweig said they had searched 28 homes and offices this week in connection with the scandal. As a result, the number of people accused of misconduct had risen from 21 to 37, including Mr Winterkorn. \"Sufficient indications have resulted from the investigation, particularly the questioning of witnesses and suspects as well as the analysis of seized data, that the accused [Mr Winterkorn] may have known about the manipulating software and its effects sooner than he has said publicly,\" the prosecutors said in a statement. VW carsImage copyrightEPA Earlier this month, VW admitted to US prosecutors that about 40 employees had deleted thousands of documents in an effort to hide systematic emissions cheating from regulators. It was also fined $4.3bn by US authorities and agreed to plead guilty to criminal charges. In addition, the carmaker has agreed to a $15bn civil settlement with environmental authorities and car owners in the US. It is also facing 8.8bn euros ($9.41bn) in damage claims following the collapse of VW's share price after the scandal broke. VW shares slumped by a third in the immediate aftermath of the scandal and are still 7% below their September 2015 level."
        article.image = UIImage(named: "8")!
        result.append(article)
        
        article = Article()
        article.title = "Australian Open 2017: Rafael Nadal to meet Roger Federer in final after epic win"
        article.text = "The Spaniard won 6-3 5-7 7-6 (7-5) 6-7 (4-7) 6-4 in almost five hours to reach a first Grand Slam final since 2014. Dimitrov's wait to reach a maiden Slam final continues after Nadal, 30, inflicted his first defeat of the year. Nadal, who is attempting to win a 15th major title, will face Swiss rival Federer, 35, in Melbourne on Sunday. \"I never dreamed to be back in the final of the Australian Open,\" said Nadal. \"It is a very special thing for both of us to be playing again in a major final. Neither of us probably thought we would be here again.\""
        article.image = UIImage(named: "9")!
        result.append(article)
        
        article = Article()
        article.title = "The perils of being fat, female and French"
        article.text = "Isabelle, a 50-year-old director of a fashionable Paris art gallery, says: \"C'est simple. Chic plus mince egale succes. (It's simple. Chic plus slim equals success).\" She is talking about French women and their figures. \"It's how it works for women here,\" Isabelle explains. \"If you are fat, you will not get that job. But if you have the silhouette - chic, ultra-slim, elegant - you are more or less made.\""
        article.image = UIImage(named: "10")!
        result.append(article)
        
        return result
    }
}
