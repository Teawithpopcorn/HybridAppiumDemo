import Foundation

struct Mocks {
    static let recipesDict = [
        [
            "name": "扬州炒饭",
            "description": "江苏扬州经典的汉族小吃。原流传于当地民间,相传源自隋朝越国公杨素爱吃的碎金饭。",
            "picture": "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1509174420278&di=fd13f91b7160fdb3c47d00f82b3250f2&imgtype=0&src=http%3A%2F%2Fcp1.douguo.net%2Fupload%2Fcaiku%2Ff%2F2%2Fd%2F200_f2b2c32940f7794587f2785545927d7d.jpg"
        ],
        
        [
            "name": "猫耳朵面",
            "description": "猫耳朵是一种风味小吃。将小面块按成猫耳朵形状，下到开水锅里煮熟，配上各种打卤、浇头，或另加配料火锅炒食。是山西著名面食之一。",
            "picture": "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=716108727,980064237&fm=11&gp=0.jpg"
        ],
        
        [
            "name": "红油饺子",
            "description": "饺子是一种历史悠久的民间吃食，深受老百姓的欢迎，民间有“好吃不过饺子”的俗语。",
            "picture": "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1477616683,2317662849&fm=27&gp=0.jpg"
        ]
    ]
    
    static var recipes: [Recipe] {
        let data = try! JSONSerialization.data(withJSONObject: Mocks.recipesDict, options: .prettyPrinted)
        return try! JSONDecoder().decode([Recipe].self, from: data)
    }
}
