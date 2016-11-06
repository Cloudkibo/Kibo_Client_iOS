//
//  UtilityFunctions.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 04/11/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class UtilityFunctions{
    
    

    init()
    {
        
    }
    
    let imageExtensions=[
        "gif",
        "jpeg",
        "jpg",
        "png",
        "tif",
        "tiff",
        "wbmp",
        "ico",
        "jng",
        "bmp",
        "svg",
        "svgz",
        "webp"
    ]
    
     let DEFAULT_MIME_TYPE = "application/octet-stream"
    
    let mimeTypes = [
        "html": "text/html",
        "htm": "text/html",
        "shtml": "text/html",
        "css": "text/css",
        "xml": "text/xml",
        "gif": "image/gif",
        "jpeg": "image/jpeg",
        "jpg": "image/jpeg",
        "js": "application/javascript",
        "atom": "application/atom+xml",
        "rss": "application/rss+xml",
        "mml": "text/mathml",
        "txt": "text/plain",
        "jad": "text/vnd.sun.j2me.app-descriptor",
        "wml": "text/vnd.wap.wml",
        "htc": "text/x-component",
        "png": "image/png",
        "tif": "image/tiff",
        "tiff": "image/tiff",
        "wbmp": "image/vnd.wap.wbmp",
        "ico": "image/x-icon",
        "jng": "image/x-jng",
        "bmp": "image/x-ms-bmp",
        "svg": "image/svg+xml",
        "svgz": "image/svg+xml",
        "webp": "image/webp",
        "woff": "application/font-woff",
        "jar": "application/java-archive",
        "war": "application/java-archive",
        "ear": "application/java-archive",
        "json": "application/json",
        "hqx": "application/mac-binhex40",
        "doc": "application/msword",
        "pdf": "application/pdf",
        "ps": "application/postscript",
        "eps": "application/postscript",
        "ai": "application/postscript",
        "rtf": "application/rtf",
        "m3u8": "application/vnd.apple.mpegurl",
        "xls": "application/vnd.ms-excel",
        "eot": "application/vnd.ms-fontobject",
        "ppt": "application/vnd.ms-powerpoint",
        "wmlc": "application/vnd.wap.wmlc",
        "kml": "application/vnd.google-earth.kml+xml",
        "kmz": "application/vnd.google-earth.kmz",
        "7z": "application/x-7z-compressed",
        "cco": "application/x-cocoa",
        "jardiff": "application/x-java-archive-diff",
        "jnlp": "application/x-java-jnlp-file",
        "run": "application/x-makeself",
        "pl": "application/x-perl",
        "pm": "application/x-perl",
        "prc": "application/x-pilot",
        "pdb": "application/x-pilot",
        "rar": "application/x-rar-compressed",
        "rpm": "application/x-redhat-package-manager",
        "sea": "application/x-sea",
        "swf": "application/x-shockwave-flash",
        "sit": "application/x-stuffit",
        "tcl": "application/x-tcl",
        "tk": "application/x-tcl",
        "der": "application/x-x509-ca-cert",
        "pem": "application/x-x509-ca-cert",
        "crt": "application/x-x509-ca-cert",
        "xpi": "application/x-xpinstall",
        "xhtml": "application/xhtml+xml",
        "xspf": "application/xspf+xml",
        "zip": "application/zip",
        "bin": "application/octet-stream",
        "exe": "application/octet-stream",
        "dll": "application/octet-stream",
        "deb": "application/octet-stream",
        "dmg": "application/octet-stream",
        "iso": "application/octet-stream",
        "img": "application/octet-stream",
        "msi": "application/octet-stream",
        "msp": "application/octet-stream",
        "msm": "application/octet-stream",
        "docx": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
        "xlsx": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        "pptx": "application/vnd.openxmlformats-officedocument.presentationml.presentation",
        "mid": "audio/midi",
        "midi": "audio/midi",
        "kar": "audio/midi",
        "mp3": "audio/mpeg",
        "ogg": "audio/ogg",
        "m4a": "audio/x-m4a",
        "ra": "audio/x-realaudio",
        "3gpp": "video/3gpp",
        "3gp": "video/3gpp",
        "ts": "video/mp2t",
        "mp4": "video/mp4",
        "mpeg": "video/mpeg",
        "mpg": "video/mpeg",
        "mov": "video/quicktime",
        "webm": "video/webm",
        "flv": "video/x-flv",
        "m4v": "video/x-m4v",
        "mng": "video/x-mng",
        "asx": "video/x-ms-asf",
        "asf": "video/x-ms-asf",
        "wmv": "video/x-ms-wmv",
        "avi": "video/x-msvideo"
    ]
    
    func MimeType(ext: String?) -> String {
        if ext != nil && mimeTypes.contains({ $0.0 == ext!.lowercaseString }) {
            return mimeTypes[ext!.lowercaseString]!
        }
        return DEFAULT_MIME_TYPE
    }
    
    
     var header:[String:String]=["kibo-app-id":DatabaseObjectInitialiser.getInstance().appid,"kibo-app-secret":DatabaseObjectInitialiser.getInstance().secretid,"kibo-client-id":DatabaseObjectInitialiser.getInstance().clientid]
    
    func uploadFile(chatstanza:[String:AnyObject],filePath1:String,file_name1:String,file_type1:String)
    {
        
        var parameters = JSON([
            "chatmsg": chatstanza])
        
        
        /*var parameterJSON = JSON([
         "to": to1,
         "from": from1,
         "uniqueid": uniqueid1,
         "file_name": file_name1,
         "file_size": file_size1,
         "file_type": file_type1
         /*to
         from
         uniqueid
         file_name
         file_size
         file_type
         */
         ])
         
         */
        // JSON stringify
        // let parameterString = parameterJSON.rawString(NSUTF8StringEncoding, options: NSJSONWritingOptions.PrettyPrinted )
        // let jsonParameterData = parameterString!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        var imageData=NSData(contentsOfFile: filePath1)
        print("mimetype is \(MimeType(file_type1))")
        
        var urlupload=Constants.uploadFileKiboEngage
        
        
        Alamofire.upload(
            .POST,
            urlupload,
            headers: header,
            multipartFormData: { multipartFormData in
                multipartFormData.appendBodyPart(data: imageData!, name: "file"
                    ,fileName: file_name1, mimeType: self.MimeType(file_type1))
                //,fileName: file_name1, mimeType: "image/\(file_type1)")
                do{for (key, value) in parameters {
                    print("key is \(key) value is \(value.description)")
                    multipartFormData.appendBodyPart(data:  try value.rawData(options: NSJSONWritingOptions.PrettyPrinted), name: key)
                    }}catch{
                        print("cannot convert value to NSData")
                }
                ///multipartFormData.appendBodyPart(data: jsonParameterData!, name: "goesIntoForm")
                
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.progress { bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
                        dispatch_async(dispatch_get_main_queue()) {
                            let percent = (Float(totalBytesWritten) / Float(totalBytesExpectedToWrite))
                            /////progress(percent: percent)
                            //uncomment later
                            if(DatabaseObjectInitialiser.getInstance().delegateProgressUpload != nil)
                            {
                                if(percent<1.0)
                                {
                                    DatabaseObjectInitialiser.getInstance().delegateProgressUpload.updateProgressUpload(percent,uniqueid: chatstanza["uniqueid"] as! String)
                                }
                                
                            }
                            //Redraw specific table cell
                            print("percentage is \(percent)")
                        }
                    }
                    upload.validate()
                    upload.responseJSON { response in
                        print(response.response?.statusCode)
                        print(response.data!)
                        
                        switch response.result {
                        case .Success:
                            
                            
                           /* var imParas=["from":from1,"to":to1,"fromFullName":"\(displayname)","msg":file_name1,"uniqueid":uniqueid1,"type":"file","file_type":type1]
                            print("imparas are \(imParas)")
                            
                            
                            var statusNow="pending"
                            
                            
                            
                            //------
                            
                            
                            socketObj.socket.emitWithAck("im",["room":"globalchatroom","stanza":imParas])(timeoutAfter: 150000)
                            {data in
                                
                                print("chat ack received  \(data)")
                                statusNow="sent"
                                var chatmsg=JSON(data)
                                print(data[0])
                                print(chatmsg[0])
                                sqliteDB.UpdateChatStatus(chatmsg[0]["uniqueid"].string!, newstatus: chatmsg[0]["status"].string!)
                                
                                //^^^self.retrieveChatFromSqlite(self.selectedContact)
                                //self.tblForChats.reloadData()
                                
                                
                                
                            }
                            /*if(self.delegateChat != nil)
                             {
                             self.delegateChat?.socketReceivedMessageChat("updateUI", data: nil)
                             }
                             if(self.delegate != nil)
                             {
                             self.delegate?.socketReceivedMessage("updateUI", data: nil)
                             }
                             */
                            
                            if(self.delegateProgressUpload != nil)
                            {
                                self.delegateProgressUpload.updateProgressUpload(1.0,uniqueid: uniqueid1)
                                
                            }
                            */
                            if(DatabaseObjectInitialiser.getInstance().delegateProgressUpload != nil)
                                {
                                DatabaseObjectInitialiser.getInstance().delegateProgressUpload.updateProgressUpload(1.0,uniqueid: chatstanza["uniqueid"] as! String)
                                
                            }
                            //debugPrint(response)
                            print("file upload success")
                            print(response.result.value)
                            print(JSON(response.result.value!)) // "status":"success"
                        case .Failure(let error):
                            print("file upload failure")
                        }
                        //debugPrint(response)
                        /*print("response 2 nsdata is \(JSON((response.2?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength))!)))")
                         print("statuscode is \(response.1?.statusCode)")
                         print("jsonn response is \(response.1!)")
                         print(response.2?.description)
                         print(JSON(response.2!))
                         */
                        //  print("response is \(response.debugDescription)")
                        // print("response result value is \(response.result.value)")
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                    print("failureeeeeeee")
                }
                
            }
        )
        
        
    }
    
    
    func downloadFile(requestID:String,fileuniqueid:String,filePendingName:String,filefrom:String,filetype:String,filePendingSize:String,filependingDate:String,filePendingTo:String)
    {
        print("inside download")
        let path = NSFileManager.defaultManager().URLsForDirectory(.ApplicationSupportDirectory, inDomains: .UserDomainMask)[0] as NSURL
        //print("path download is \(path)")
        //////// let newPath = path.URLByAppendingPathComponent(fileName1)
        /////// print("full path download file is \(newPath)")
        //////  let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
        //  print("path download is \(destination.lowercaseString)")
        //  Alamofire.download(.GET, "http://httpbin.org/stream/100", destination: destination)
        var downloadURL=Constants.downloadFileKiboEngage
        
        let destination: (NSURL, NSHTTPURLResponse) -> (NSURL) = {
            (temporaryURL, response) in
            
            if let directoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0] as? NSURL {
                //// var localImageURL = directoryURL.URLByAppendingPathComponent("\(response.suggestedFilename!)")
                //filenamePending
                var localImageURL = directoryURL.URLByAppendingPathComponent(filePendingName)
                
                /*let checkValidation = NSFileManager.defaultManager()
                 
                 if (checkValidation.fileExistsAtPath("\(localImageURL)"))
                 {
                 print("FILE AVAILABLE")
                 }
                 else
                 {
                 print("FILE NOT AVAILABLE")
                 }*/
                
                
                print("localpathhhhhh \(localImageURL.debugDescription)")
                return localImageURL
            }
            print("tempurl is \(temporaryURL.debugDescription)")
            return temporaryURL
        }
        
        
        print("downloading call unique id \(fileuniqueid)")
        Alamofire.download(.POST, "\(downloadURL)", headers:header, parameters: ["uniqueid":fileuniqueid], destination: destination)
            .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
                print("writing bytes \(totalBytesRead)")
                print(" bytes1 \(bytesRead)")
                print("totalBytesRead bytes \(totalBytesRead)")
                var progressbytes=(Float(totalBytesRead)/Float(totalBytesExpectedToRead)) as Float
                print("totalBytesExpectedToRead are \(totalBytesExpectedToRead)")
                
                if(DatabaseObjectInitialiser.getInstance().delegateProgressUpload != nil)
                {
                    if(progressbytes<1.0)
                    {
                        
                        print("calling delegate progress bar.....")
                        DatabaseObjectInitialiser.getInstance().delegateProgressUpload.updateProgressUpload(progressbytes,uniqueid: fileuniqueid)
                    }
                    
                }
                
                /* if(self.delegateProgressUpload != nil)
                 {
                 if(progressbytes<1.0)
                 {
                 
                 print("calling delegate progress bar.....")
                 self.delegateProgressUpload.updateProgressUpload(progressbytes,uniqueid: fileuniqueid)
                 }
                 
                 }
                 */
                
                /* if(self.delegateProgressUpload != nil)
                 {print("progress download value is \(progressbytes)")
                 self.delegateProgressUpload.updateProgressUpload(progressbytes,uniqueid: fileuniqueid)
                 
                 }*/
            }
            .response { (request, response, _, error) in
                print(response)
                print("1...... \(request?.URLString)")
                print("2..... \(request?.URL.debugDescription)")
                print("3.... \(response?.URL.debugDescription)")
                
                
                let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
                let docsDir1 = dirPaths[0]
                var documentDir=docsDir1 as NSString
                var filePendingPath=documentDir.stringByAppendingPathComponent(filePendingName)
                
               if(self.imageExtensions.contains(filetype.lowercaseString))
               {
                    //filePendingName
                
                
                //set file type doc or image from mimetype
                DatabaseObjectInitialiser.getDB().storeFiles(filePendingTo, from1: filefrom, date1: NSDate(), uniqueid1: fileuniqueid, type1: "image", filename1: filePendingName, filesize1: filePendingSize, filetype1: filetype, filepath1: filePendingPath, requestid1: requestID)
                
                }
                else
                {
                   DatabaseObjectInitialiser.getDB().storeFiles(filePendingTo, from1: filefrom, date1: NSDate(), uniqueid1: fileuniqueid, type1: "document", filename1: filePendingName, filesize1: filePendingSize, filetype1: filetype, filepath1: filePendingPath, requestid1: requestID)
                    
                }
               
               //UPDATE UI
                //filedownloaded’ to with parameters ‘senderoffile’, ‘receiveroffile’
                
                
                // print(request?.)
                
        }
    }

}


