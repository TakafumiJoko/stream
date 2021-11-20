class S3filesController < ApplicationController
  
  skip_before_action :check_logged_in, only: [:new, :index]

  def new
    @s3file = S3file.new()
  end
  
  def create
    file = s3file_params[:key]
    
    file_path = "tmp/#{file.original_filename}"
    File.binwrite(file_path, file.read)
    
    s3file = S3file.new()
    s3file.save
    
    filename = "assets#{s3file.id.to_s}/#{file.original_filename}"
    
    s3file.update_attribute(:key, filename)

    bucket = @s3.bucket(@bucketname)
  
    object = bucket.object(s3file.key)
    
    object.upload_file(file_path, acl: 'public-read')
    
    redirect_to s3file
  end
  
  def index
    
  end

  def show
    @s3file = S3file.find(params[:id])
  end
  
  def initialize
    super
    @region = 'ap-northeast-1'
    @bucketname = 'bucket-for-stream'
    @s3 = get_s3_resource
  end
  
  private
  def get_s3_resource
    Aws::S3::Resource.new(region: @region)
  end
  
  def s3file_params
    params.require(:s3file).permit(:key)
  end
end
