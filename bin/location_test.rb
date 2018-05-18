

@session = nil
@dde_link = "http://#{ARGV[0]}/v1"


def start

  url = "#{@dde_link}/login"
  user_credentials = {username: 'admin', password: 'bht.dde3!'}
  output = JSON.parse(RestClient.post url, user_credentials)
  @session = output['access_token']

  url = "#{@dde_link}/list_locations"
  output = RestClient::Request.execute( { :method => :post, :url => url,
  :headers => {:Authorization => @session} } )

  results  = JSON.parse(output)
  puts "##### #{results.first['doc_id']}"
  location_id = results.first['doc_id']

  url = "#{@dde_link}/npids_assigned"
  output = RestClient::Request.execute( { :method => :post, :url => url,
  :payload => {location_doc_id: results[0]['doc_id']}, 
  :headers => {:Authorization => @session} } )

  results  = JSON.parse(output)
  puts "##### #{results}"

  url = "#{@dde_link}/total_allocated_npids"
  output = RestClient::Request.execute( { :method => :post, :url => url,
  :payload => {location_doc_id: location_id}, 
  :headers => {:Authorization => @session} } )

  results  = JSON.parse(output)
  puts "##### #{results}"


end

start
