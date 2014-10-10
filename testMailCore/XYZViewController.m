//
//  XYZViewController.m
//  testMailCore
//
//  Created by gitBurning on 14-10-10.
//  Copyright (c) 2014年 gitBurning. All rights reserved.
//

#import "XYZViewController.h"
#import <MailCore/MailCore.h>

@interface XYZViewController ()

@end

@implementation XYZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    /**
     获取 邮箱 内容
     
     :returns: <#return value description#>
     */
    
    //    MCOIMAPSession *session = [[MCOIMAPSession alloc] init];
    //    [session setHostname:@"imap.126.com"];  // 如果是163邮箱，则是 imap.163.com  等等
    //    [session setPort:993];                  //端口 不会变
    //    [session setUsername:@"burning_git@126.com"];// 126邮箱
    //    [session setPassword:@"xxxxxxx"];            // 密码
    //    [session setConnectionType:MCOConnectionTypeTLS];
    //
    //    MCOIMAPMessagesRequestKind requestKind = MCOIMAPMessagesRequestKindHeaders;
    //    NSString *folder = @"Sent Messages";
    //    //Sent Messages   INBOX
    //    MCOIndexSet *uids = [MCOIndexSet indexSetWithRange:MCORangeMake(1, UINT64_MAX)];
    //
    //    MCOIMAPFetchMessagesOperation *fetchOperation = [session fetchMessagesByUIDOperationWithFolder:folder requestKind:requestKind uids:uids];
    //
    //    [fetchOperation start:^(NSError * error, NSArray * fetchedMessages, MCOIndexSet * vanishedMessages) {
    //
    //
    //
    //        if(error) {
    //            NSLog(@"Error downloading message headers:%@", error);
    //        }
    //
    //
    //        NSLog(@"The post man delivereth:%@", [fetchedMessages lastObject]);
    //    }];
    
    
    
    /**
     发邮件
     
     :returns: <#return value description#>
     */
    
    MCOSMTPSession *smtpSession = [[MCOSMTPSession alloc] init];
    smtpSession.hostname = @"smtp.163.com";//smtp.gmail.com
    
    [smtpSession setPort:465];
    smtpSession.username = @"burning_git@163.com";
    smtpSession.password = @"xxxxxxxxxx";//  需要 手动 输入密码
    smtpSession.authType = MCOAuthTypeSASLPlain;
    smtpSession.connectionType = MCOConnectionTypeTLS;
    
    MCOMessageBuilder *builder = [[MCOMessageBuilder alloc] init];
    MCOAddress *from = [MCOAddress addressWithDisplayName:@"Matt R"
                                                  mailbox:@"burning_git@163.com"];
    MCOAddress *to = [MCOAddress addressWithDisplayName:@"12342"
                                                mailbox:@"974201360@qq.com"];
    [[builder header] setFrom:from];
    [[builder header] setTo:@[to]];
    [[builder header] setSubject:@"My message"];
    [builder setHTMLBody:@"This is a test message!"];
    
    
    NSString *file=[[NSBundle mainBundle] pathForResource:@"key" ofType:@"txt"];
    builder.attachments=@[[MCOAttachment attachmentWithContentsOfFile:file]];
    NSData * rfc822Data = [builder data];
    
    MCOSMTPSendOperation *sendOperation =
    [smtpSession sendOperationWithData:rfc822Data];
    [sendOperation start:^(NSError *error) {
        if(error) {
            NSLog(@"Error sending email: %@", error);
        } else {
            NSLog(@"Successfully sent email!");
        }
    }];
    
    sendOperation.progress =^(unsigned int current, unsigned int maximum){
        NSLog(@"当前进度%d",current);
        
    };
    
    

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
