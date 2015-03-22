import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
class httpStuff {
  String urlToSend;
  
  httpStuff(String url) {

      urlToSend = url;
     
}

  public void sendRequest(float value, String type)
  {
      try
    {
    DefaultHttpClient httpClient = new DefaultHttpClient();
    StringEntity data = new StringEntity("");
    
    if (type == "positivity") {
      data = new StringEntity("[{\"positivity\":" + value + "}]");
    } else {
      data = new StringEntity("[{\"hbpm\":" + value + "}]");
    }

    HttpPost          httpPost   = new HttpPost( urlToSend );
                      httpPost.addHeader("Content-Type", "application/json;charset=UTF-8");
                      httpPost.setEntity(data);
    
    println( "executing request: " + httpPost.getRequestLine() );
    println( httpPost.getEntity() );
    
    HttpResponse response = httpClient.execute( httpPost );
    HttpEntity   entity   = response.getEntity();
    
    
    println("----------------------------------------");
    println( response.getStatusLine() );
    println("----------------------------------------");
    
    if( entity != null ) entity.writeTo( System.out );
    if( entity != null ) entity.consumeContent();

    
    // When HttpClient instance is no longer needed, 
    // shut down the connection manager to ensure
    // immediate deallocation of all system resources
    httpClient.getConnectionManager().shutdown();       
    
  } catch( Exception e ) { e.printStackTrace(); }
 
  }
    
    
}



