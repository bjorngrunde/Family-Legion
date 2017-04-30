class Dungeon::Delete < Trailblazer::Operation

  step Model(Dungeon, :find_by)
  step Policy::Pundit(AdminPolicy, :delete? )
  step Contract::Build(constant: Dungeon::Contract::Delete)
  step :delete_images!
  step :delete_dungeon!

  def delete_dungeon!(options, **)
    options["model"].destroy
  end

  def delete_images!(options, **)
    options["contract.default"].image do |v|
      v.delete!
    end
  end
end
