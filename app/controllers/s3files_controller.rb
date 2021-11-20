class S3filesController < ApplicationController
  
  skip_before_action :check_logged_in, only: [:index]

  def new
    @channels = current_user.channels
    channel = Channel.new()
    @s3file = channel.s3files.build
  end
  
  def create
    
    file = s3file_params[:key]
    filename = file.original_filename
    file_path = "tmp/#{filename}"
    File.binwrite(file_path, file.read)
    
    S3file.create(key: filename, channel_id: s3file_params[:channel_id])
    @s3file = S3file.last

    bucket = @s3.bucket(@bucketname)
    object = bucket.object("assets#{@s3file.id.to_s}/#{filename}")
    object.upload_file(file_path, acl: 'public-read')
    
    file = s3file_params[:image]
    filename = file.original_filename
    file_path = "tmp/#{filename}"
    File.binwrite(file_path, file.read)
    
    @s3file.update_attribute(:image, filename)
    
    object = bucket.object("assets#{@s3file.id.to_s}/#{filename}")
    object.upload_file(file_path, acl: 'public-read')
    
    redirect_to @s3file
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
    params.require(:s3file).permit(:key, :image, :channel_id)
  end
end
