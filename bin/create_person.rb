
@session = nil
@dde_link = "http://#{ARGV[0]}/v1"

def start
  url = "#{@dde_link}/login"
  user_credentials = {username: 'admin', password: 'bht.dde3!'}
  output = JSON.parse(RestClient.post url, user_credentials)
  @session = output['access_token']

  url = "#{@dde_link}/add_person"

  1.upto(ARGV[1].to_i).each do |n|
    person_params = fake_people(n)
    puts person_params

    output = RestClient::Request.execute( { :method => :post, :url => url,
    :payload => person_params, 
    :headers => {:Authorization => @session} } )

    results  = JSON.parse(output)
    puts "##### #{results['_id']}"
  end

end

def fake_people(n)
  gender = ['F','M']

  params = {
    given_name:   Faker::Name.first_name,
    family_name:  Faker::Name.last_name,         
    middle_name:  nil,
    gender: gender[rand(0..1)],          
    birthdate:  Faker::Date.birthday(0, 75).strftime('%Y-%m-%d'),              
    birthdate_estimated: rand(0..1),   
    attributes: {
      occupation: "",
      cellphone_number: Faker::PhoneNumber.cell_phone,           
      current_district: Faker::Address.city,            
      current_traditional_authority: Faker::Address.community,
      current_village: Faker::Address.street_name,            
      home_district: Faker::Address.city,        
      home_traditional_authority: Faker::Address.community,      
      home_village: Faker::Address.street_name      
    },
    identifiers: {art_number: "ART #{rand(1..1000000)}", htn_number: nil}
  }   

  return params
end







start
