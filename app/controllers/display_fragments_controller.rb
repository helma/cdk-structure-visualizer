class DisplayFragmentsController < ApplicationController

  def index
    
    errors = []
    activating_smarts = []
    activating_p = []
    deactivating_smarts = []
    deactivating_p = []
    unknown_smarts = []

    # read input
    smiles = params[:smiles]
    unless params[:fragments][:activating].blank?
      activating_smarts = params[:fragments][:activating].collect{|smarts,p| smarts.chomp}
      activating_p = params[:fragments][:activating].collect{|smarts,p| p}
    end
    unless params[:fragments][:deactivating].blank?
      deactivating_smarts = params[:fragments][:deactivating].collect{|smarts,p| smarts.chomp}
      deactivating_p = params[:fragments][:deactivating].collect{|smarts,p| p}
    end
    unknown_smarts = params[:fragments][:unknown] if params[:fragments][:unknown] 

    # check syntax
    errors << "No Smiles structure provided" if smiles.blank?
    errors << "Unknown fragments have to be an array with Smarts patterns" unless unknown_smarts.blank? or unknown_smarts.class == Array
    errors << "Activating fragments have to be an hash with Smarts patterns pointing to p-values" unless activating_smarts.blank? or params[:fragments][:activating].class == HashWithIndifferentAccess
    errors << "Dectivating fragments have to be an hash with Smarts patterns pointing to p-values" unless deactivating_smarts.blank? or params[:fragments][:deactivating].class == HashWithIndifferentAccess

    # render image
    if errors.blank?
      begin
        display = Rjb::import('DisplayStructure').new
        image = display.displaySubstructureP(smiles,activating_smarts,deactivating_smarts,unknown_smarts, activating_p, deactivating_p)
        out=Rjb::import('java.io.ByteArrayOutputStream').new
        Rjb::import('javax.imageio.ImageIO').write(image, "png", out)
        send_data(out.toByteArray, :type => "image/png", :disposition => "inline", :filename => "molecule.png")
      rescue
        render :text => "Display of #{smiles} failed", :status => :bad_request
      end
    else
      render :text => errors.join('<br/>'), :status => :bad_request
    end

	end

end
