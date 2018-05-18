
@session = nil
@dde_link = "http://localhost:3000/v1"

def start
  url = "#{@dde_link}/login"
  user_credentials = {username: 'admin', password: 'bht.dde3!'}
  output = JSON.parse(RestClient.post url, user_credentials)
  @session = output['access_token']

  begin
    url = "#{@dde_link}/search_by_npid"
    output = RestClient::Request.execute( { :method => :post, :url => url,
    :payload => {npid: 'ART 875919', doc_id: '!!!!45462db705c0143097c462e11621ae06'}, 
    :headers => {:Authorization => @session} } )
  rescue
    return
  end

  puts "######### #{output}"
  
  begin
    url = "#{@dde_link}/search_by_attributes"
    output = RestClient::Request.execute( { :method => :post, :url => url,
    :payload => {values: ['ART 875919','Pine Village','Summer Oaks']}, 
    :headers => {:Authorization => @session} } )
  rescue
    return
  end

  puts "######### #{output}"

  begin
    url = "#{@dde_link}/search_by_doc_id"
    output = RestClient::Request.execute( { :method => :post, :url => url,
    :payload => {doc_id: '0a3ee893d259d27d320022d213faab79'}, 
    :headers => {:Authorization => @session} } )
  rescue
    return
  end

  puts "######### #{output}"

  begin
    url = "#{@dde_link}/search_by_name_and_gender"
    output = RestClient::Request.execute( { :method => :post, :url => url,
    :payload => {given_name: 'Houston', family_name: 'Wilkinson', gender: 'M'}, 
    :headers => {:Authorization => @session} } )
  rescue
    return
  end

  puts "######### #{output}"

end

start
