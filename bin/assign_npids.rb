
@session = nil
@dde_link = "http://#{ARGV[0]}/v1"

def start

  url = "#{@dde_link}/login"
  user_credentials = {username: 'admin', password: 'bht.dde3!'}
  output = JSON.parse(RestClient.post url, user_credentials)
  @session = output['access_token']

  begin
    url = "#{@dde_link}/assign_npids"
    output = RestClient::Request.execute( { :method => :post, :url => url,
    :payload => {limit: ARGV[1].to_i}, 
    :headers => {:Authorization => @session} } )
  rescue
    return
  end

  puts "########## #{output}"
end

start
