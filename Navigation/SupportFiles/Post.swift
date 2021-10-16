//
//  Post.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 25.08.2021.
//

import Foundation

public struct Post {
    public var title: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
}

public let post1 = Post(title: "Бла бла новость номер 1",
                 description: "Хочешь узнать больше о мобильной разработке? Присоединяйся к 4 открытым АМА-сессиям бизнес-акселератора Game Drive. Регистрируйся и учись у лучших экспертов индустрии: https://mgvc.com/gamedrive",
                 image: "1", likes: 0, views: 0)
public let post2 = Post(title: "Бла бла новость номер 2",
                 description: "Хочешь узнать больше об акселераторе Google Growth Lab? 12 августа мы проведем AMA-сессию!☺Эксперты Google, менторы и выпускники подробно расскажут о программе и критериях отбора заявок, а также ответят на твои вопросы. Регистрируйся по ссылке: https://bit.ly/3fM9MDt",
                 image: "2", likes: 0, views: 0)
public let post3 = Post(title: "Бла бла новость номер 3",
                 description: "4 инди-игры из России прошли в финал Indie Games Festival! Хочешь поддержать российских разработчиков? Регистрируйся по ссылке и получи возможность первым познакомиться с проектами победителей в режиме онлайн! https://bit.ly/3lnBvOF",
                 image: "3", likes: 0, views: 0)
public let post4 = Post(title: "Бла бла новость номер 4",
                 description: "Ровно 70 лет назад археологи нашли первую берестяную грамоту в Великом Новгороде! Сегодня мы празднуем этот день вместе с новым #GoogleDoodle, ведь это настоящая возможность прикоснуться к прошлому. Челобитные, поручения, рисунки мальчика Онфима… а сколько еще предстоит найти!",
                 image: "4", likes: 0, views: 0)

public var postArray: [Post] = [post1, post2, post3, post4]
