require 'sinatra'

set :public_folder, 'public'

get '/' do
  haml :index
end

post '/upload' do
  File.open('public/uploads/' + params['file'][:filename], "w") do |f|
    f.write(params['file'][:tempfile].read)
  end
  
  @files = []
  Dir.glob("public/uploads/*").each do |file|
    @files << File.open(file, "r")
  end
  
  haml :upload
end

helpers do
  def to_mb(value)
    value/1024/1024
  end
end
