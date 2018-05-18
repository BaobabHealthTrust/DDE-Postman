
@session = nil
@dde_link = "http://localhost:3000/v1"

def start
  url = "#{@dde_link}/login"
  user_credentials = {username: 'admin', password: 'bht.dde3!'}
  output = JSON.parse(RestClient.post url, user_credentials)
  @session = output['access_token']

  primary_doc_id    = ARGV[0]
  secondary_doc_id  = ARGV[1]

  begin
    url = "#{@dde_link}/merge_people"
    output = RestClient::Request.execute( { :method => :post, :url => url,
    :payload => {primary_person_doc_id: primary_doc_id, secondary_person_doc_id: secondary_doc_id}, 
    :headers => {:Authorization => @session} } )
  rescue
    return
  end

  puts "######### #{output}"

end

start
