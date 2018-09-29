class Wowapi::Initialize < Trailblazer::Operation

	step :init!

	def init!(options, **)
		RBattlenet.authenticate(api_key: ENV['BATTLE_NET_KEY'])
		RBattlenet.set_region(region: ENV['BATTLE_NET_REGION'], locale: ENV['BATTLE_NET_LOCALE'])
	end
end
