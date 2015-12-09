//: Playground - noun: a place where people can play

import UIKit
import SwiftHTTPTV

enum VODErrors: ErrorType {
    case NeedToPay
    case NoAccess
    case Other(reason: String)
}

class repoCheck {
    static func UpdateRepo() {
        print("Updating repo")
    }
}

class xbmcaddon {
    var id: String
    init(id: String) {
        self.id = id
    }
    func getAddonInfo(prop: String) -> String?{
        switch(prop) {
        case "icon" :
            return nil
        case "profile":
            return "/hello"
        default:
            return nil
        }
    }
    
    func getLocalizedString(i: String) -> String{
        return self.id
    }
    func getSetting(prop: String) -> String? {
        switch(prop) {
        case "sortBy":
            return "0"
        default:
            return nil
        }
    }
    
    static func Addon(id: String) -> xbmcaddon{
        return xbmcaddon(id: id)
    }
}
class xbmcgui {
    static var items = [[String:Any?]]()
    static func ListItem(title:String?=nil, iconImage:String?=nil, thumbnailImage:String?=nil, path:String?=nil) -> [String:Any?] {
        let i:[String:Any?] = ["title": title, "iconImage": iconImage, "thumbnailImage": thumbnailImage, "path": path]
        //        func setInfo(type: String, infoLabels: String) {
        //            i["type"] = type
        //            i["infoLabels"] = infoLabels
        //            i.removeValueForKey("setInfo")
        //        }
        //        i["setInfo"] = setInfo
        //        def setProperty(key, value):
        //            i[key] = value
        //        i["setProperty"] = setProperty
        xbmcgui.items.append(i)
        return i
    }
}
class xbmc {
    static func getInfoLabel(property: String) -> String?{
        switch(property) {
        case "System.BuildVersion":
            return "15.0"
        default:
            return nil
        }
    }
    
    static func translatePath(path: String) -> String {
        return path
    }
    
    static func executebuiltin(str: String) {
        print("executing "+str)
    }
}
class xbmcplugin {
    static var items:[Dictionary<String, Any?>] = []
    static var content = ""
    static func addDirectoryItem(url:String?,listitem:[String:Any?],isFolder:Bool?, totalItems:Int=0) {
        xbmcplugin.items.append(["url": url, "listitem": listitem, "isFolder": isFolder, "totalItems" : totalItems])
    }
    static func setContent(str:String?) {
        xbmcplugin.content = str!
    }
    static func endOfDirectory() -> [Dictionary<String, Any?>] {
        return xbmcplugin.items
    }
    static func setResolvedUrl(succeeded:Bool? = false, listitem:Any? = nil) {
        print(listitem)
    }
}

let xbmc_version = xbmc.getInfoLabel( "System.BuildVersion" )

let AddonID = "plugin.video.MakoTV"
let Addon = xbmcaddon.Addon(AddonID)
let AddonName = "MakoTV"
let icon = Addon.getAddonInfo("icon")
let localizedString = Addon.getLocalizedString
let sortBy = Int(Addon.getSetting("sortBy")!)

let userDir = xbmc.translatePath(Addon.getAddonInfo("profile")!)
let link1 = "http://www.mako.co.il/AjaxPage?jspName=playlist.jsp&vcmid=%@&videoChannelId=%@&consumer=web&encryption=no"
let link2 = "http://mass.mako.co.il/ClicksStatistics/entitlementsServices.jsp?et=gt&na=2.0&da=6gkr2ks9-4610-392g-f4s8-d743gg4623k2&du=%@&dv=%@&rv=akamai&lp=%@"

//if (isXbmc and !os.path.exists(userDir)) {
//    os.makedirs(userDir)
//}

func GetCategoriesList() {
    repoCheck.UpdateRepo()
    var name = "תוכניות"
    addDir(name, url:"http://www.mako.co.il/mako-vod-index", mode: 0, iconimage: "http://img.mako.co.il/2010/08/11/mako%20vod%20c.jpg", infos: ["Title": name, "Plot": "MakoTV programs"])
    name = "תוכניות ילדים"
    addDir(name, url: "http://www.mako.co.il/mako-vod-kids", mode: 0, iconimage: "http://now.tufts.edu/sites/default/files/111116_kids_TV_illo_L.JPG", infos: ["Title": name, "Plot": "Kids shows"])
    name = "קלטות ילדים"
    addDir(name, url: "http://www.mako.co.il/mako-vod-kids", mode: 0, iconimage: "http://img.agora.co.il/deals_images/2013-08/936426.jpg", infos: ["Title": name, "Plot": "Kids tapes"])
    name = "לייף סטייל"
    addDir(name, url: "http://www.mako.co.il/mako-vod-more/lifestyle", mode: 0, iconimage: "http://cdn-media-2.lifehack.org/wp-content/files/2012/12/healthy-lifestyle.jpg", infos: ["Title": name, "Plot": "Life style"])
    name = "דוקמנטרי"
    addDir(name, url: "http://www.mako.cmode: o.iiconimage: l/mako-vod-more/docu_tv", mode: 0, iconimage: "http://opendoclab.mit.edu/wp/wp-content/infos: uploads/2011/09/camera.jpg", infos: ["Title": name, "Plot": "Documentaries"])
    name = "תכניות"
    addDir(name, url: "http://www.mako.comode: .iliconimage: /mako-vod-more/concerts", mode: 0, iconimage: "http://www.scenewave.com/wp-content/uploads/An-arinfos: gument-for-live-music1.jpg", infos: ["Title": name, "Plot": "Live shows"])
    name = "הרצאות"
    addDir(name, url: "http://www.mako.co.il/mako-vod-more/lectures", mode: 0, iconimage: "http://static1.squarespace.com/static/545c3cefe4b0263200cf8bb7/t/5474d191e4b0dda9e3ce84e7/1416941970318/lecture.jpg?format=1500w", infos: ["Title": name, "Plot": "Lectures"])
    //let sortString = sortBy! == 0 ? localizedString(30001).stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) : localizedString(30002).stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
    //name = "{0}: {1}".format(localizedString(30000).encode("utf-8"), sortString)
    //addDir(name, "toggleSortingMethod", 6, "", {"Title": name, "Plot": "{0}[CR]Change method:[CR]{1} / {2}".format(name, localizedString(30001).encode("utf-8"), localizedString(30002).encode("utf-8"))}, isFolder=False)
    name = "חיפוש"
    addDir(name, url: "http://www.mako.co.il/autocomplete/vodAutocompletion.ashx?query={0}&max=60&id=query",mode: 5 ,iconimage: "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQlAUVuxDFwhHYzmwfhcUEBgQXkkWi5XnM4ZyKxGecol952w-Rp", infos: ["Title": name, "Plot": "Search"])
}

func GetSeriesList(catName:String, url:String, var iconimage:String?) {
    let url = url.rangeOfString("?") == nil ? url+"?type=service" : url+"&type=service"
    let prms1 = GetJson(url)
    if prms1 == nil{
        NSException(name: "Error", reason: "Cannot get "+catName+" list", userInfo: nil).raise()
        return
    }
    
    var key1:String?
    var key2:String?
    var picKey = "picUrl_F"
    
    switch(catName) {
    case "תוכניות":
        key1 = "allPrograms"
        break
    case "תוכניות ילדים":
        key1 = "kidsPrograms"
        break
    case "קלטות ילדים":
        key1 = "kidsCassettes"
        break
    case "תוכניות", "הרצאות":
        key1 = "moreVOD"
        key2 = "items"
        picKey = "picB"
    default:
        key1 = "moreVOD"
        key2 = "programItems"
    }
    var prms = []
    if (key2 == nil) {
        if (prms1![key1!] == nil) {
            NSException(name: "Error", reason: "Cannot get "+catName+" list", userInfo: nil).raise()
            return
        }
        prms = (prms1![key1!] as? NSArray)!
    } else {
        if (prms1![key1!] == nil || prms1![key1!]![key2!] == nil) {
            NSException(name: "Error", reason: "Cannot get "+catName+" list", userInfo: nil).raise()
            return
        }
        prms = (prms1![key1!] as? Dictionary<String, [String]>)![key2!]!
    }
    
    let seriesCount = prms.count
    for prm in prms {
        do {
            var name = prm["title"] as! String
            let mode = (prm["url"] as! String).rangeOfString("VOD-") != nil ? 4 : 1
            if (mode == 4 && prm["subtitle"] != nil && prm["subtitle"]!!.count > 0) {
                name = name + " - " + (prm["subtitle"] as! String)
            }
            let url = "http://www.mako.co.il" + (prm["url"] as! String)
            iconimage = prm[picKey] as? String
            if (iconimage == nil) {
                iconimage = prm["pic"] as? String
            }
            if (iconimage == nil) {
                iconimage = prm["picUrl"] as? String
            }
            var description = ""
            if (prm["brief"]! != nil) {
                description = prm["brief"] as! String
            }
            if (prm["plot"]! != nil) {
                description += " - " + (prm["plot"] as! String)
            }
            let infos:Dictionary<String, String> = ["Title": name, "Plot": description]
            addDir(name, url: url, mode: mode, iconimage:iconimage!, infos: infos, totalItems:seriesCount)
        } catch {
            print ("\(error)")
        }
    }
}

func GetSeasonsList(url:String, iconimage:String) {
    var url = url.characters.indexOf("?") != nil ? url+"&type=service" : url+"?type=service"
    let prms = GetJson(url)
    if (prms == nil || prms!["programData"] == nil || prms!["programData"]!["seasons"] == nil) {
        print("Cannot get Seasons list")
        return
    }
    for prm in prms!["programData"]!["seasons"] as! NSArray{
        do {
            if (prm["vods"] == nil) {
                continue
            }
            let name = prm["name"]!!
            url = "http://www.mako.co.il" + (prm["url"] as! String)
            let description = prm["brief"]!!
            let infos:Dictionary<String, String> = ["Title": name as! String, "Plot": description as! String]
            addDir(name as! String, url: url, mode: 2, iconimage: iconimage, infos: infos)
        } catch {
            print ("\(error)")
        }
    }
}

func GetEpisodesList(var url:String) {
    url = url.characters.indexOf("?") != nil ? url+"&type=service" : url+"?type=service"
    let prms = GetJson(url)
    
    if (prms == nil || prms!["channelId"] == nil || prms!["programData"] == nil || prms!["programData"]!["seasons"] == nil) {
        print("Cannot get Seasons list")
        return
    }
    let videoChannelId=prms!["channelId"] as? String
    for prm in prms!["programData"]!["seasons"] as! NSArray {
        if (prm["vods"] == nil || prm["current"] == nil || (prm["current"] as! String).lowercaseString != "true") {
            continue
        }
        let episodesCount = prm["vods"]!!.count
        for episode in prm["vods"] as! NSArray{
            do {
                let vcmid = episode["guid"] as? String
                let name = (episode["title"]!! as! String) + " - " + (episode["shortSubtitle"]!! as! String)
                url = "http://www.mako.co.il/VodPlaylist?vcmid="+vcmid!+"&videoChannelId="+videoChannelId!
                let iconimage =  episode["picUrl"] as? String
                let description = episode["subtitle"]!!
                let infos:Dictionary<String, String> = ["Title": name, "Plot": description as! String, "Aired": (episode["date"] as! String).characters.split{$0 == " "}.map(String.init)[1] ]//  [episode["date"].find(" ")+1:]]
                addDir(name, url: url, mode: 3, iconimage: iconimage!, infos: infos, totalItems:episodesCount)
            } catch {
                print ("\(error)")
            }
        }
    }
}

func PlayItem(url:String) throws {
    var url = url.characters.indexOf("?") != nil ? url+"&type=service" : url+"?type=service"
    let prms = GetJson(url)
    
    if (prms == nil || prms!["video"] == nil) {
        print("Cannot get item")
        return
    }
    
    let videoChannelId=prms!["channelId"] as? String
    let vcmid = prms!["video"]!["guid"] as? String
    url = "http://www.mako.co.il/VodPlaylist?vcmid="+vcmid!+"&videoChannelId="+videoChannelId!
    try Play(url)
}

func Play(url:String) throws -> String? {
    let start = url.rangeOfString("vcmid=")
    let end = url.rangeOfString("&videoChannelId=")
    let guid = url.substringWithRange(Range<String.Index>(start: (start?.startIndex.advancedBy(6))!, end:(end?.startIndex)!))
    let suffix = url.substringFromIndex((end?.startIndex.advancedBy(16))!)
    var link = link1
    let u = String(format: link, guid, suffix)
    var text = OpenURL(u)
    let _: NSError?
    let parsedObject: AnyObject? = try NSJSONSerialization.JSONObjectWithData(text!,
        options: NSJSONReadingOptions.AllowFragments)
    var result = parsedObject!["media"]
    var url = ""
    for item in result as! NSArray{
        if ((item["format"] as! String) == "AKAMAI_HLS") {
            url = item["url"] as! String
            break
        }
    }
    let uuidStr = NSUUID.init().UUIDString
    
    
    let du = "W" + uuidStr.substringToIndex(uuidStr.startIndex.advancedBy(8)) + uuidStr.substringFromIndex(uuidStr.startIndex.advancedBy(9))
    link = link2
    let start2 = url.rangeOfString("/i/")
    text = OpenURL(String(format: link, du, guid, url.substringFromIndex((start2?.startIndex)!)))
    result = try NSJSONSerialization.JSONObjectWithData(text!,
        options: NSJSONReadingOptions.AllowFragments)
    if ((result!!["caseId"] as! String) == "4") {
        throw VODErrors.NeedToPay
    } else if ((result!!["caseId"] as! String) != "1") {
        throw VODErrors.NoAccess
    }
    let final = url+"?"+(result!!["tickets"]!![0]["ticket"] as! String)
    return final
}


func OpenURL(url:String, var headers:Dictionary<String, String>=Dictionary<String, String>(), user_data:[String]=[], retries:Int=3) -> NSData? {
    do {
        let UA = "Mozilla/5.0 (iPhone; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3"
        headers.updateValue(UA, forKey: "User-Agent")
        let urlenc = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        let req = try HTTP.GET(urlenc!, parameters: user_data, headers: headers)
        var link:NSData? = nil
        var waiting = true
        for _ in 0...retries {
            req.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                //print("opt finished: \(response.description)")
                link = NSString(data: response.data, encoding: NSUTF8StringEncoding)!.dataUsingEncoding(NSUTF8StringEncoding)
                waiting = false
            }
        }
        while(waiting) {
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate())
            usleep(10)
        }
        return link
    } catch {
        print ("\(error)")
        return nil
    }
}

func GetJson(url:String) -> NSDictionary? {
    do {
        let html = OpenURL(url)
        if html == nil {
            return nil
        }
        let response: AnyObject? = try NSJSONSerialization.JSONObjectWithData(html!, options: NSJSONReadingOptions())
        if let userDict = response as? NSDictionary {
            if (userDict["root"] != nil) {
                return userDict["root"] as? NSDictionary
            } else {
                return userDict
            }
        } else {
            return nil
        }
    } catch {
        print ("\(error)")
        return nil
    }
}

//func Search(var url: String, search: String = "") {
//    if (search != "") {
//        //url = url.format(search_entered)
//        let params = GetJson(url)
//        let suggestions = params!["suggestions"]
//        let data = params!["data"] as! [String]
//        for i in 0...suggestions!.length {
//            if (data[i].rangeOfString("mako-vod-channel2-news") != nil) {
//                continue
//            }
//            let name = suggestions![i].stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
//            var mode:Int
//            if (data[i].rangeOfString("VOD-") != nil) {
//                mode = 4
//            } else {
//                mode = 1
//            }
//            url = "http://www.mako.co.il" + data[i]
//            addDir(name, url, mode, "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQlAUVuxDFwhHYzmwfhcUEBgQXkkWi5XnM4ZyKxGecol952w-Rp", ["Title": name, "Plot": name])
//        }
//    } else {
//        return
//    }
//}

//func ToggleSortMethod() {
//    if (sortBy == 0) {
//        Addon.setSetting("sortBy", "1")
//    } else {
//        Addon.setSetting("sortBy", "0")
//    xbmc.executebuiltin("XBMC.Container.Refresh()")
//    }
//}
func addDir(name: String, url:String, mode:Int, var iconimage:String = "", infos:Dictionary<String, String>=Dictionary<String, String>(), totalItems:Int = 0, var isFolder:Bool=true) {
    var u = "url="+url
    u+="&mode="+String(mode)
    u+="&name="+name
    u+="&iconimage="+iconimage
    if (iconimage == "") {
        iconimage = "DefaultFolder.png"
    }
    var liz = xbmcgui.ListItem(name, iconImage:"DefaultFolder.png", thumbnailImage:iconimage)
    liz["type"]="Video"
    liz["infoLabels"]=infos
    if (mode==3 ||  mode==4) {
        isFolder=false
        liz["IsPlayable"] = "true"
    }
    if (totalItems == 0) {
        xbmcplugin.addDirectoryItem(u,listitem:liz,isFolder:isFolder)
    } else {
        xbmcplugin.addDirectoryItem(u,listitem:liz,isFolder:isFolder,totalItems:totalItems)
    }
}

func get_params(var params:String) -> Dictionary<String, String>{
    var ans = Dictionary<String, String>()
    if (params.characters.count>2) {
        let cleanedparams = params.stringByReplacingOccurrencesOfString("?", withString: "&")
        if (params.characters.last == "/") {
            params = params.substringToIndex(params.endIndex.advancedBy(-2))
        }
        let pairsofparams = cleanedparams.characters.split("&")
        for i in 0...pairsofparams.count-1 {
            let splitparams = pairsofparams[i].split("=")
            if (splitparams.count == 2) {
                ans.updateValue(String(splitparams[1]), forKey: String(splitparams[0]))
            }
        }
    }
    return ans
}

func vod(p:String, view:ViewController) throws -> [Dictionary<String, Any?>] {
    xbmcgui.items.removeAll()
    xbmcplugin.items.removeAll()
    let params = get_params(p)
    var url: String?
    var mode:Int?
    var name: String?
    var iconimage:String?
    
    url = params["url"]
    if (params["mode"] != nil) {
        mode = Int(params["mode"]!)
    }
    name = params["name"]
    iconimage = params["iconimage"]
    
    
    if (mode == nil || url == nil || url!.characters.count < 1) {
        //print "------------- Categories: -----------------"
        GetCategoriesList()
    } else if (mode == 0) {
        //print "------------- Series: -----------------"
        GetSeriesList(name!, url: url!, iconimage:iconimage)
    } else if (mode == 1) {
        //print "------------- Seasons: -----------------"
        GetSeasonsList(url!, iconimage:iconimage!)
    } else if (mode == 2) {
        //print "------------- Episodes: -----------------"
        GetEpisodesList(url!)
    } else if (mode == 3) {
        //print "------------- Playing episode  -----------------"
        try view.AVPlay(Play(p))
    } else if (mode == 4) {
        //print "------------- Playing item: -----------------"
        try PlayItem(url!)
    } else if (mode == 5) {
        //print "------------- Search items: -----------------"
        //Search(url!)
    } else if (mode == 6) {
        //print "------------- Toggle Lists" sorting method: -----------------"
        //ToggleSortMethod()
    }
    
    xbmcplugin.setContent("episodes")
    xbmc.executebuiltin("Container.SetViewMode(504)")
    if (sortBy == 1 && mode != nil && mode != 5) {
        //xbmcplugin.addSortMethod(1)
    }
    return xbmcplugin.endOfDirectory()
}
