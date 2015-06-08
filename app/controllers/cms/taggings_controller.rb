class Cms::TaggingsController < CmsController

  def destroy
    @tagging = Tagging.find_by(post_id: params['post_id'], tag_id: params['tag_id'])
    # Rails.logger.debug("### Tagging ###: #{@tagging.inspect}")

    # @tagging.destroy
    respond_to do |format|
      if @tagging && @tagging.destroy
        format.json { render json: nil, status: :ok }
      else
        format.json { render json: nil, status: :unprocessable_entity }
      end
    end
  end

end
