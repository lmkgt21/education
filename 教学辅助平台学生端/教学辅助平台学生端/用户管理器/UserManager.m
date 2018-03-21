//
//  UserManager.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2017/12/29.
//  Copyright © 2017年 郭挺. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

//保留全局的static的实例
static UserManager *userManager = nil;
//提供一个类方法让外界访问唯一的实例
+(instancetype)sharedUserManager{
    //线程安全
    @synchronized(self){
        if(userManager == nil){
            userManager = [[self alloc] init];
        }
    }
    return userManager;
}
-(void)toRegister:(NSString *)username with:(NSString *)password block:(CompleteBlock) complete
{
    //先查用户是否存在
    BmobQuery *bmobQuery = [BmobQuery queryWithClassName:@"userlist_student"];
    [bmobQuery whereKey:@"username" equalTo:username];
    [bmobQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            //查表失败，返回0
            complete(0);
        }
        else if (array.count == 0)
        {
            //用户不存在，进行注册
            BmobObject *bmobObject = [BmobObject objectWithClassName:@"userlist_student"];
            [bmobObject setObject:username forKey:@"username"];
            [bmobObject setObject:password forKey:@"password"];
            [bmobObject setObject:[NSNumber numberWithBool:NO] forKey:@"isManager"];//默认不是管理员
            [bmobObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    complete(1);//注册成功，返回1
                }
                else if (error)
                {
                    complete(0);//注册失败，返回0
                }
            }];
        }
        else
        {
            complete(-1);//该用户已经注册，返回-1
        }
    }];
}

-(void)logInUser:(NSString *)username with:(NSString *)password block:(CompleteBlock) complete
{
    BmobQuery *bmobQuery = [BmobQuery queryWithClassName:@"userlist_student"];
    [bmobQuery whereKey:@"username" equalTo:username];
    [bmobQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            complete(0);//查表失败，返回0
        }
        else if (array.count == 0)
        {
            complete(-1);//用户名不存在，返回-1
        }
        else
        {
            if ([password isEqualToString:[array[0] objectForKey:@"password"]]) {
                complete(1);//登录成功，返回1
                [self saveObjectIdToLocal:[array[0] objectId] isManager:[[array[0] objectForKey:@"isManager"] boolValue] username:[array[0] objectForKey:@"username"]];//保存objectId
            }
            else
            {
                complete(-2);//密码不正确，返回-2
            }
        }
    }];
}
//退出登录
-(void)logOut
{
    [self deleteObjectIdFromLocal];//删除当前用户
    [self deleteIsManager];//删除管理员信息
    [self deleteUsernameFromLocal];
    self.userInfo = nil;//清空内存中的信息
}
//更改密码
-(void)changeWithNewPassword:(NSString *) password block:(CompleteBlock) complete
{
    BmobObject *bmobObject = [BmobObject objectWithoutDataWithClassName:@"userlist_student" objectId:[self getObjectIdFromLocal]];
    [bmobObject setObject:password forKey:@"password"];
    [bmobObject updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            complete(1);//成功返回1
        }
        else
        {
            complete(0);//失败返回-1
        }
    }];
}
//更新用户信息
-(void)updateUserInfoFromBackgroundWithblock:(CompleteBlock) complete
{
    BmobQuery *bmobQuery = [BmobQuery queryWithClassName:@"userlist_student"];
    [bmobQuery getObjectInBackgroundWithId:[self getObjectIdFromLocal] block:^(BmobObject *object, NSError *error) {
        if (error) {
            complete(0);//更新失败，返回0
        }else
        {
            [self saveToManagerWith:object];//更新成功，保存到单例
            complete(1);//更新成功，并返回1
        }
    }];
}
//判断是否登录
-(BOOL)isLogin
{
    if ([self getObjectIdFromLocal] != nil) {
        return YES;
    }
    return NO;
}
-(void)saveToManagerWith:(BmobObject *)userInfo
{
    self.userInfo = userInfo;
}
-(void)saveObjectIdToLocal:(NSString *) objectId isManager:(BOOL) isManager username:(NSString *)username
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:objectId forKey:@"objectId"];
    [userDefaults setBool:isManager forKey:@"isManager"];
    [userDefaults setObject:username forKey:@"username"];
    [userDefaults synchronize];
}
-(void)deleteIsManager
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"isManager"];
    [userDefaults synchronize];
}
-(void)deleteObjectIdFromLocal
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"objectId"];
    [userDefaults synchronize];
}
-(void)deleteUsernameFromLocal
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"username"];
    [userDefaults synchronize];
}
-(BOOL)getIsManagerFromLocal
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults synchronize];
    return [userDefaults boolForKey:@"isManager"];
}
-(NSString *)getObjectIdFromLocal
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults synchronize];
    return [userDefaults objectForKey:@"objectId"];
}
-(NSString *)getUsernameFromLocal
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults synchronize];
    return [userDefaults objectForKey:@"username"];
}
//------------资料模块-----------
//新建文件夹
-(void)newFolderWithName:(NSString *)folderName path:(NSString *) path block:(CompleteBlock) complete
{
    BmobQuery *bmobQuery = [BmobQuery queryWithClassName:@"folder_book_list"];
    [bmobQuery whereKey:@"path" equalTo:path];
    [bmobQuery whereKey:@"folderName" equalTo:folderName];//路径和名称唯一代表一个文件名
    [bmobQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            complete(0);//查表失败，返回0
        }
        else if (array.count == 0)
        {
            //查表成功，该名称不存在，进行新建
            BmobObject *bmobObject = [BmobObject objectWithClassName:@"folder_book_list"];
            [bmobObject setObject:path forKey:@"path"];
            [bmobObject setObject:folderName forKey:@"folderName"];
            [bmobObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    complete(1);//新建成功，返回1
                }
                else
                {
                    complete(0);//失败，返回0
                }
            }];
        }
        else
        {
            //该文件名已存在，返回-1
            complete(-1);
        }
    }];
}
//删除文件夹
-(void)removeFolderWithObjectId:(NSString *)objectId Name:(NSString *)folderName path:(NSString *) path block:(CompleteBlock) complete
{
    BmobQuery *bmobQuery = [BmobQuery queryWithClassName:@"folder_book_list"];
    [bmobQuery whereKey:@"path" equalTo:[NSString stringWithFormat:@"%@/%@",path,folderName]];//查看该文件夹里是否有书籍或者文件夹
    [bmobQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            complete(0);//查表失败，返回0
        }
        else if (array.count == 0)
        {
            //查表成功，该文件夹为空文件夹，可以删除
            BmobObject *bmobObject = [BmobObject objectWithoutDataWithClassName:@"folder_book_list" objectId:objectId];
            [bmobObject deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    //删除成功，返回1
                    complete(1);
                }
                else
                {
                    //删除失败，返回0
                    complete(0);
                }
            }];
        }
        else
        {
            //该文件夹存在内容，无法删除！
            complete(-1);
        }
    }];
}
//新建书籍
-(void)newBookWithName:(NSString *)bookName info:(NSDictionary *)bookInfo path:(NSString *) path block:(CompleteBlock) complete
{
    BmobObject *bmobObject = [BmobObject objectWithClassName:@"folder_book_list"];
    [bmobObject setObject:path forKey:@"path"];
    [bmobObject setObject:bookName forKey:@"bookName"];
    [bmobObject setObject:bookInfo forKey:@"bookInfo"];
    [bmobObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            complete(1);//新建成功，返回1
        }
        else
        {
            complete(0);//失败，返回0
        }
    }];
}
//删除书籍
-(void)removeBookWithObjectId:(NSString *)objectId block:(CompleteBlock) complete
{
    BmobObject *bmobObject = [BmobObject objectWithoutDataWithClassName:@"folder_book_list" objectId:objectId];
    [bmobObject deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            complete(1);
        }
        else
        {
            complete(0);
        }
    }];
}
//获取某个路径下的文件夹
-(void)getFolderWithPath:(NSString *)path block:(CompleteAndResultBlock) completeAndResult
{
    BmobQuery *bmobQuery = [BmobQuery queryWithClassName:@"folder_book_list"];
    [bmobQuery whereKeyExists:@"folderName"];
    [bmobQuery whereKey:@"path" equalTo:path];
    [bmobQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            completeAndResult(0,nil);//获取失败，返回0和nil
        }
        else
        {
            completeAndResult(1,array);//获取成功，返回1和数据
        }
    }];
}
//获取某个路径下的书籍
-(void)getBookWithPath:(NSString *)path block:(CompleteAndResultBlock) completeAndResult
{
    BmobQuery *bmobQuery = [BmobQuery queryWithClassName:@"folder_book_list"];
    [bmobQuery whereKeyExists:@"bookName"];
    [bmobQuery whereKey:@"path" equalTo:path];
    [bmobQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            completeAndResult(0,nil);//获取失败，返回0和nil
        }
        else
        {
            completeAndResult(1,array);//获取成功，返回1和数据
        }
    }];
}
//保存反馈到后台
-(void)saveSuggestionToBackgroundWith:(NSString *)username type:(NSString *)type description:(NSString *)description contact:(NSString *)contact block:(CompleteBlock) complete
{
    BmobObject *bmobObject = [BmobObject objectWithClassName:@"suggest_list_s"];
    [bmobObject setObject:username forKey:@"username"];
    [bmobObject setObject:type forKey:@"type"];
    [bmobObject setObject:description forKey:@"description"];
    [bmobObject setObject:contact forKey:@"contact"];
    [bmobObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            complete(1);//成功返回1
        }
        else
        {
            complete(0);//失败返回0
        }
    }];
}
//设置用户信息
-(void)setUserInfoWithDic:(NSDictionary *)userInfo block:(CompleteBlock) complete
{
    BmobObject *bmobObject = [BmobObject objectWithoutDataWithClassName:@"userlist_student" objectId:[self getObjectIdFromLocal]];
    [bmobObject setObject:userInfo forKey:@"userInfo"];
    [bmobObject updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //提交成功
            complete(1);
        }
        else
        {
            //提交失败
            complete(0);
        }
    }];
}
//获取用户信息
-(NSDictionary *)getUserInfo
{
    NSDictionary *userInfo = [self.userInfo objectForKey:@"userInfo"];
    return userInfo;
}

//------------课堂模块-----------
//-----教师端------
//新建一个课程
-(void)newCourseWithName:(NSString *)coursename teacher:(BmobObject *)teacher block:(CompleteBlock) complete
{
    BmobObject *bmobObject = [BmobObject objectWithClassName:@"course_list"];
    [bmobObject setObject:teacher forKey:@"course"];
    [bmobObject setObject:coursename forKey:@"coursename"];
    [bmobObject setObject:[teacher objectForKey:@"username"] forKey:@"teachername"];
    [bmobObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //新建成功，返回1
            complete(1);
        }
        else
        {
            //新建失败，返回0
            complete(0);
        }
    }];
}
//删除指定的课程
-(void)removeCourseWithObjectId:(NSString *)objectId block:(CompleteBlock) complete
{
    BmobObject *bmobObject = [BmobObject objectWithoutDataWithClassName:@"course_list" objectId:objectId];
    [bmobObject deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            complete(1);//成功返回1
        }
        else
        {
            complete(0);//失败返回0
        }
    }];
}
//获取某个教师的所有课程
-(void)getCoursesWithTeacher:(BmobObject *)techer block:(CompleteAndResultBlock) completeAndResult
{
    BmobQuery *bmobQuery = [BmobQuery queryWithClassName:@"course_list"];
    [bmobQuery whereKey:@"course" equalTo:techer];
    [bmobQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            completeAndResult(0,nil);//获取失败，返回0和nil
        }
        else
        {
            completeAndResult(1,array);//获取成功，返回1和数据
        }
    }];
}
//保存到题库（选择题）
-(void)saveToBankWithQuestion:(NSString *)question choiceA:(NSString *)choiceA choiceB:(NSString *)choiceB choiceC:(NSString *)choiceC choiceD:(NSString *)choiceD andAnswer:(NSString *)answer score:(NSNumber *)score block:(CompleteAndObjectBlock) completeAndObject
{
    BmobObject *bmobObject = [BmobObject objectWithClassName:@"choice_bank"];
    [bmobObject setObject:question forKey:@"question"];
    [bmobObject setObject:choiceA forKey:@"choiceA"];
    [bmobObject setObject:choiceB forKey:@"choiceB"];
    [bmobObject setObject:choiceC forKey:@"choiceC"];
    [bmobObject setObject:choiceD forKey:@"choiceD"];
    [bmobObject setObject:answer forKey:@"answer"];
    [bmobObject setObject:score forKey:@"score"];
    [bmobObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //保存成功，返回1
            completeAndObject(1,bmobObject);
        }
        else
        {
            //保存失败，返回0
            completeAndObject(0,nil);
        }
    }];
}
//拉取题库（适用于所有题型）
-(void)getQuestionsWithType:(NSString *)type block:(CompleteAndResultBlock) completeAndResult
{
    NSString *classname = [NSString stringWithFormat:@"%@_bank",type];
    BmobQuery *query = [BmobQuery queryWithClassName:classname];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            completeAndResult(0,nil);//获取失败，返回0和nil
        }
        else
        {
            completeAndResult(1,array);//获取成功，返回1和数据
        }
    }];
}
//删除指定课堂的当前作业（必须指出所有已支持的题型。题型字符串：choice、judge、fill、QandA）
-(void)deleteTaskOfCourseWithObjectId:(NSString *)objectId types:(NSArray *)types block:(CompleteBlock) complete
{
    BmobObject *course = [BmobObject objectWithoutDataWithClassName:@"course_list" objectId:objectId];
    [course deleteForKey:@"title"];//删除当前作业的标题
    for (NSString *type in types) {
        [course deleteForKey:type];
    }
    [course updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            complete(1);//删除成功，返回1
        }
        else
        {
            complete(0);//删除失败，返回0
        }
    }];
}
//添加指定题型到指定课程
-(void)addQuestions:(NSArray *)questions WithType:(NSString *)type toCourse:(BmobObject *)course
{
    BmobRelation *relation = [[BmobRelation alloc] init];
    for (BmobObject *question in questions) {
        [relation addObject:question];
    }
    [course addRelation:relation forKey:type];
}
//提交指定课程的当前作业（即所有添加的题型）到后台
-(void)submitTastWithTitle:(NSString *)title course:(BmobObject *)course block:(CompleteBlock) complete
{
    [course setObject:title forKey:@"title"];//指定当前作业的标题
    [course updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            complete(1);//提交成功，返回1
        }
        else
        {
            complete(0);//提交失败，返回0
        }
    }];
}
//获取指定课程的指定作业
-(void)getQuestionsOfCourse:(BmobObject *)course WithType:(NSString *)type block:(CompleteAndResultBlock) completeAndResult
{
    NSString *classname = [NSString stringWithFormat:@"%@_bank",type];
    BmobQuery *query = [BmobQuery queryWithClassName:classname];
    [query whereObjectKey:type relatedTo:course];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            completeAndResult(0,nil);//获取失败，返回0和nil
        }
        else
        {
            completeAndResult(1,array);//获取成功，返回1和数据
        }
    }];
}
//获取指定课程所有学生的分数
-(NSDictionary *)getAllScoreWithCourse:(BmobObject*) course
{
    NSMutableDictionary *studentDic = [NSMutableDictionary dictionaryWithDictionary:[course objectForKey:@"StudentDic"]];
    return studentDic;
}
//删除指定课程的某个学生的分数
-(void)removeScoreFromCourse:(BmobObject *) course withStudentName:(NSString *)name block:(CompleteBlock) complete
{
    BmobObject *bmobObject = [BmobObject objectWithoutDataWithClassName:@"course_list" objectId:course.objectId];
    
    NSMutableDictionary *studentDic = [NSMutableDictionary dictionaryWithDictionary:[course objectForKey:@"StudentDic"]];
    
    [studentDic removeObjectForKey:name];
    
    [bmobObject setObject:studentDic forKey:@"StudentDic"];
    [bmobObject updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //删除成功
            complete(1);
        }
        else
        {
            //删除失败
            complete(0);
        }
    }];
}
//获取指定课程的所有学生
-(void)getAllStudentsWithCourse:(BmobObject *) course block:(CompleteAndResultBlock) completeAndResult
{
    BmobQuery *query = [BmobQuery queryWithClassName:@"userlist_student"];
    
    BmobQuery *inQuery = [BmobQuery queryWithClassName:@"course_list"];
    [inQuery whereKey:@"objectId" equalTo:course.objectId];
    
    [query whereKey:@"myCourses" matchesQuery:inQuery];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            completeAndResult(0,nil);//获取失败，返回0和nil
        }
        else
        {
            completeAndResult(1,array);//获取成功，返回1和数据
        }
    }];
}
//------学生端------
//获取所有课程/检索指定的课程
-(void)getCoursesWithKeyword:(NSString *)keyword block:(CompleteAndResultBlock) completeAndResult
{
    BmobQuery *bmobQuery = [BmobQuery queryWithClassName:@"course_list"];
    if (keyword) {
        //传入关键字时添加约束条件，获取检索的课程
        NSArray *array =  @[@{@"coursename":keyword},@{@"teachername":keyword}];
        [bmobQuery addTheConstraintByOrOperationWithArray:array];
    }
    [bmobQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            completeAndResult(0,nil);//获取失败，返回0和nil
        }
        else
        {
            completeAndResult(1,array);//获取成功，返回1和数据
        }
    }];
}
//添加某个课程到当前学生用户
-(void)addCourse:(BmobObject *)course block:(CompleteBlock) complete
{
    [self updateUserInfoFromBackgroundWithblock:^(int result) {
        if (result == 1) {
            //更新成功，开始添加
            BmobObject *bmobObject = self.userInfo;
            BmobRelation *relation = [[BmobRelation alloc] init];
            [relation addObject:course];
            [bmobObject addRelation:relation forKey:@"myCourses"];
            [bmobObject updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    //添加成功
                    complete(1);
                }
                else
                {
                    //添加失败
                    complete(0);
                }
            }];
        }
        else
        {
            //更新失败，返回0
            complete(0);
        }
    }];
}
//获取当前学生用户所有课程
-(void)getCoursesOfSutentWithBlock:(CompleteAndResultBlock) completeAndResult
{
    [self updateUserInfoFromBackgroundWithblock:^(int result) {
        if (result == 1) {
            //更新成功，开始获取
            BmobQuery *query = [BmobQuery queryWithClassName:@"course_list"];
            BmobObject *bmobObject = self.userInfo;
            [query whereObjectKey:@"myCourses" relatedTo:bmobObject];
            [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                if (error) {
                    completeAndResult(0,nil);//获取失败，返回0和nil
                }
                else
                {
                    completeAndResult(1,array);//获取成功，返回1和数据
                }
            }];
        }
        else
        {
            //更新失败，返回0和nil
            completeAndResult(0,nil);
        }
    }];
}
//删除当前学生用户某个课程
-(void)removeCourse:(BmobObject *)course block:(CompleteBlock) complete
{
    [self updateUserInfoFromBackgroundWithblock:^(int result) {
        if (result == 1) {
            //更新成功，开始删除
            BmobObject *bmobObject = self.userInfo;
            BmobRelation *relation = [[BmobRelation alloc] init];
            [relation removeObject:course];
            [bmobObject addRelation:relation forKey:@"myCourses"];
            [bmobObject updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    //删除成功
                    complete(1);
                }
                else
                {
                    //删除失败
                    complete(0);
                }
            }];
        }
        else
        {
            //更新失败，返回0
            complete(0);
        }
    }];
}
//提交当前学生用户的当前作业的选择题总分到相应课程
-(void)submitChoiceScore:(double) choiceScore toCourse:(BmobObject *) course block:(CompleteBlock) complete
{
    BmobObject *bmobObject = [BmobObject objectWithoutDataWithClassName:@"course_list" objectId:course.objectId];
    
    NSMutableDictionary *studentDic = [NSMutableDictionary dictionaryWithDictionary:[course objectForKey:@"StudentDic"]];
    
    NSMutableDictionary *scoreDic = [NSMutableDictionary dictionaryWithDictionary:[studentDic objectForKey:[self.userInfo objectForKey:@"username"]]];
    NSMutableDictionary *choiceDic = [NSMutableDictionary dictionaryWithDictionary:[scoreDic objectForKey:@"choice"]];
    if ([course objectForKey:@"title"])//只有在有当前作业的情况下才能拿到值
    {
        [choiceDic setObject:[NSNumber numberWithDouble:choiceScore] forKey:[course objectForKey:@"title"]];
        [scoreDic setObject:choiceDic forKey:@"choice"];
        [studentDic setObject:scoreDic forKey:[self.userInfo objectForKey:@"username"]];
        
        [bmobObject setObject:studentDic forKey:@"StudentDic"];
        [bmobObject updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                //提交成功
                complete(1);
            }
            else
            {
                //提交失败
                complete(0);
            }
        }];
    }
    else
    {
        //无当前作业，无法提交
        complete(-1);
    }
}
//获取当前学生用户指定课程的指定题型的分数
-(NSDictionary *)getScoreWithType:(NSString*) type course:(BmobObject *) course
{
    NSMutableDictionary *studentDic = [NSMutableDictionary dictionaryWithDictionary:[course objectForKey:@"StudentDic"]];
    NSMutableDictionary *scoreDic = [NSMutableDictionary dictionaryWithDictionary:[studentDic objectForKey:[self.userInfo objectForKey:@"username"]]];
    NSMutableDictionary *choiceDic = [NSMutableDictionary dictionaryWithDictionary:[scoreDic objectForKey:type]];
    if (choiceDic) {
        return choiceDic;
    }
    else
    {
        return nil;
    }
}

@end
