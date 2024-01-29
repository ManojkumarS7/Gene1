//
//  geneData.swift
//  Gene
//
//  Created by manoj on 15/12/23.
struct geneData: Decodable {
        var data: [geneUserData]
    }

struct geneUserData: Decodable { 
    var thumpnail_url: String!
    var like_count : Int!
    var  share_count: Int!
    var comments_count: Int!
    var ID: Int!
    var template_config_data : String!
          
   

}
 
//struct TemplateConfig : Decodable {
//    
//    var zoomLevel : Double!
//    var exposureLevel: Float!
//    var focusLevel: Float!
//}
//


 /*
{
    "data": [
        {
            "ID": "eb809bc7-1d73-4c4e-b82a-0dda8671b252",
            "template_config_data": {
                "zoom": 2,
                "ae/af": 7.77,
                "flash": false
            },
            "thumpnail_url": "https://expertphotography.b-cdn.net/wp-content/uploads/2019/04/female-face-girl-posing-outdoors-in-natural-light.jpg",
            "like_count": 1000000,
            "comments_count": 1000000,
            "share_count": 1000000
        },
        {
            "ID": "3ca07eb2-0c62-4bab-be52-a3869a5b58bc",
            "template_config_data": {
                "zoom": 2,
                "ae/af": 7.77,
                "flash": false
            },
            "thumpnail_url": "https://www.theclickcommunity.com/blog/wp-content/uploads/2017/01/portrait-of-boy-in-a-red-and-black-shirt-by-Kristin-Dokoza.jpg",
            "like_count": 233,
            "comments_count": 54,
            "share_count": 10
        },
        {
            "ID": "fdc51552-97b8-42dc-b186-b932e9786165",
            "template_config_data": {
                "zoom": 2,
                "ae/af": 7.77,
                "flash": false
            },
            "thumpnail_url": "https://www.theclickcommunity.com/blog/wp-content/uploads/2017/01/portrait-of-boy-in-a-red-and-black-shirt-by-Kristin-Dokoza.jpg",
            "like_count": null,
            "comments_count": null,
            "share_count": null
        },
        {
            "ID": "f341e505-f32c-4a6f-84e3-cf2c0443b4b3",
            "template_config_data": null,
            "thumpnail_url": null,
            "like_count": null,
            "comments_count": null,
            "share_count": null
        },
        {
            "ID": "0a83690d-e807-46e8-959c-8ed919ba03cc",
            "template_config_data": null,
            "thumpnail_url": null,
            "like_count": null,
            "comments_count": null,
            "share_count": null
        },
        {
            "ID": "fe28a38a-28ee-44d1-b940-94083294bf56",
            "template_config_data": null,
            "thumpnail_url": null,
            "like_count": null,
            "comments_count": null,
            "share_count": null
        }
    ]
}
*/

