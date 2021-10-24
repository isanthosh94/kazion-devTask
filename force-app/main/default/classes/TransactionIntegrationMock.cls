/*
@Name            : TransactionIntegrationMock
@Author          : Santhosh Ilangovan
@Date            : Oct 24, 2021
@Description     : Mock Test Class for Named Credential Transaction_Integration
*/
@isTest
public class TransactionIntegrationMock implements HttpCalloutMock{
    
    public HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
    	response.setStatusCode(200);
        return response;
    }    
}