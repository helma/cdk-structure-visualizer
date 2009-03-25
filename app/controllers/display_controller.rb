class DisplayController < ApplicationController

	def index

    # sanitize smiles
    if request.get?
      smiles = CGI.unescape(params[:smiles])
    elsif request.post?
      smiles = params[:smiles]
    else
      render :text => "Please use GET or POST to display chemical structures", :status => :method_not_allowed
    end
    begin
      display = Rjb::import('DisplayStructure').new
      image = display.displaySmiles(smiles)
      out=Rjb::import('java.io.ByteArrayOutputStream').new
      Rjb::import('javax.imageio.ImageIO').write(image, "png", out)
      send_data(out.toByteArray, :type => "image/png", :disposition => "inline", :filename => "molecule.png")
    rescue
      render :text => "Display of #{smiles} failed", :status => :bad_request
    end
	end

end
