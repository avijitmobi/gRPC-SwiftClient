//
//  GRPCRepository.swift
//  TestGRPCProject
//
//  Created by Avijit Mondal on 23/03/22.
//

import Foundation
import NIO
import GRPC
import SwiftProtobuf


class GRPCRepository {
    

    // 1
    var channel : GRPCChannel!
    
    //2
    let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    
    //3
    required init() {
        startConnection()
    }
    
    func startConnection(){
        channel = ClientConnection
            .insecure(group: eventLoopGroup)
            .connect(host: "localhost", port: 8000)
    }
    
    // 4
    var studentClient : Student_StudentServiceClient?{
        get{
            return Student_StudentServiceClient.init(channel: channel)
        }
    }
    
    
    // 5
    func getAllStudent(responseCallback: ((_ result : Student_StudentList?,_ error : Error?)->())?){
        studentClient?.findStudents(Student_Empty()).response.whenCompleteBlocking(onto: DispatchQueue.main, { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let resp):
                    responseCallback?(resp, nil)
                case .failure(let error):
                    responseCallback?(nil, error)
                }
            }
        })
    }
    
}
