class DownloadsController < ApplicationController

  reader_but_not_user_required

  def show
    @download = Download.find(params[:id])
    if @download.available_to?(current_reader)
      response.headers['X-Accel-Redirect'] = @download.document.path
      response.headers["Content-Type"] = @download.document_content_type
      response.headers['Content-Disposition'] = "attachment; filename=\"#{@download.document}\"" 
      response.headers['Content-Length'] = @download.document_file_size
    else
      flash[:error] = "Sorry: you don't have permission to download that file."
      render :template => 'site/not_allowed'
    end
  end
  
end

