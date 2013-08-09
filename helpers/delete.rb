enable :sessions

begin
  
  def delete(id)
    
    User.where(:id=>id).delete
    @er_message = "Record deleted"
    
  end 
     
end