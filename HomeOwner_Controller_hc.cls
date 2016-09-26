public class HomeOwner_Controller_hc {    
    public String loggedInUserId {get;set;}
    public String loggedInFirstName {get;set;}
    public String loggedInLastName {get;set;}
    public String loggedInAccountId {get;set;}
    public String loggedInContactId {get;set;}
    private integer counter = 0;  //keeps track of the offset
    private integer list_size=1; //sets the page size or number of rows
    public integer total_size; //used to show user the total size of the list
    public String fullURL {get;set;}
    
    public Account account {get;set;}
    
    public HomeOwner_Controller_hc()
    {
        fullURL = URL.getSalesforceBaseUrl().toExternalForm();
        loggedInUserId = UserInfo.getUserId();
        loggedInFirstName = UserInfo.getFirstName();
        loggedInLastName = UserInfo.getLastName();
        
        List<User> user = [Select ContactId from User where Id =:loggedInUserId];
        loggedInContactId = user[0].ContactId;
        
        List<Contact> contact = [Select AccountId from Contact where Id =:loggedInContactId];
        //loggedInAccountId='001n00000095uwI';
        loggedInAccountId = contact[0].AccountId;
        
        total_size = [select count() from Asset where Homeowner__r.id =:loggedInAccountId];
        
        getHomeOwnerInfo();
    }
    public void Save(){
      try{
         update account;
      }
      catch(Exception e){
            String message='Data Base error during saving...';
            ApexPages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR, message));
            
        }
    }
    }