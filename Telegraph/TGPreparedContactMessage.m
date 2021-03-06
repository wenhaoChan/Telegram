#import "TGPreparedContactMessage.h"

#import <LegacyComponents/LegacyComponents.h>

@implementation TGPreparedContactMessage

- (instancetype)initWithUid:(int32_t)uid firstName:(NSString *)firstName lastName:(NSString *)lastName phoneNumber:(NSString *)phoneNumber vcard:(NSString *)vcard replyMessage:(TGMessage *)replyMessage replyMarkup:(TGReplyMarkupAttachment *)replyMarkup
{
    self = [super init];
    if (self != nil)
    {
        _uid = uid;
        _firstName = firstName;
        _lastName = lastName;
        _phoneNumber = phoneNumber;
        _vcard = vcard;
        self.replyMessage = replyMessage;
        self.replyMarkup = replyMarkup;
    }
    return self;
}

- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName phoneNumber:(NSString *)phoneNumber vcard:(NSString *)vcard replyMessage:(TGMessage *)replyMessage replyMarkup:(TGReplyMarkupAttachment *)replyMarkup
{
    return [self initWithUid:0 firstName:firstName lastName:lastName phoneNumber:phoneNumber vcard:vcard replyMessage:replyMessage replyMarkup:replyMarkup];
}

- (TGMessage *)message
{
    TGMessage *message = [[TGMessage alloc] init];
    message.mid = self.mid;
    message.date = self.date;
    message.isBroadcast = self.isBroadcast;
    message.messageLifetime = self.messageLifetime;
    
    NSMutableArray *attachments = [[NSMutableArray alloc] init];
    
    TGContactMediaAttachment *contactAttachment = [[TGContactMediaAttachment alloc] init];
    contactAttachment.uid = _uid;
    contactAttachment.firstName = _firstName;
    contactAttachment.lastName = _lastName;
    contactAttachment.phoneNumber = _phoneNumber;
    contactAttachment.vcard = _vcard;
    [attachments addObject:contactAttachment];
    
    if (self.replyMessage != nil)
    {
        TGReplyMessageMediaAttachment *replyMedia = [[TGReplyMessageMediaAttachment alloc] init];
        replyMedia.replyMessageId = self.replyMessage.mid;
        replyMedia.replyMessage = self.replyMessage;
        [attachments addObject:replyMedia];
    }
    
    if (self.replyMarkup != nil) {
        [attachments addObject:self.replyMarkup];
    }
    
    message.mediaAttachments = attachments;
    
    return message;
}

@end
