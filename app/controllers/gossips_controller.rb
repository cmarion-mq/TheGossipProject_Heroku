class GossipsController < ApplicationController
  def index
    @all_gossips = Gossip.all
  end

  def show
    @gossip = Gossip.find(params[:id])
    @comment = Comment.new
  end
  
  def new
    # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
    @gossip = Gossip.new
  end
  
  def create
    if current_user
      @gossip = Gossip.new(title: params[:title], content: params[:content], user: current_user) # avec xxx qui sont les données obtenues à partir du formulaire

      if @gossip.save # essaie de sauvegarder en base @gossip
        redirect_to "/index"
        flash[:info] = "Gossip Saved!!"
        # si ça marche, il redirige vers la page d'index du site
      else
        redirect_to "/gossips/new", notice: "Erreur de sauvegarde"
        # sinon, il render la view new (qui est celle sur laquelle on est déjà)
      end
    else
      redirect_to "/sessions/new", notice: "Log obligatoire pour créer un gossip"
    end
  end
  
  def edit
    @gossip = Gossip.find(params[:id])
  end

  def post_params
    post_params = params.require(:gossip).permit(:title, :content)
  end

  def update
    @gossip = Gossip.find(params[:id])
    if @gossip = Gossip.find(params[:id])
      @gossip.update(post_params)
      redirect_to index_path
    else
      render 'edit'
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to "/index"
  end
end
