SoundManager = {};
local this = SoundManager;

SoundEvent = {};
SoundEvent.Sound_attack = 1;
SoundEvent.Sound_hurt = 2;
SoundEvent.Sound_dead = 3;
SoundEvent.Sound_skill = 4;


function SoundManager.New()
	-- body
	return this;
end

function SoundManager.PlayerBackMusic(musicname)
	audio.playMusic(musicname,true);
end

function SoundManager.PlayerEffect(event,soundidx)
	-- body
	if event == SoundEvent.Sound_attack then
		--todo
		audio.playSound("sound/sound_fight_attack.mp3");
	elseif event == SoundEvent.Sound_hurt then
		--todo
		audio.playSound("sound/sound_fight_hurt.mp3");
	elseif event == SoundEvent.Sound_dead then
		--todo
		audio.playSound("sound/sound_fight_male_dead.wav");
	elseif event == SoundEvent.Sound_skill then
		--todo
		audio.playSound(string.format("sound/music_skill%d.mp3",soundidx));
	end
end

function SoundManager.StopBackMusic()
	-- body
	audio.stopMusic();
end

function SoundManager.PlayHurtMusic()
	-- body
	SoundManager.PlayerEffect(SoundEvent.Sound_hurt);
end

function SoundManager.PlayAttackMusic()
	-- body
	SoundManager.PlayerEffect(SoundEvent.Sound_attack);
end

function SoundManager.PlayDeadMusic()
	-- body
	SoundManager.PlayerEffect(SoundEvent.Sound_hurt);
end

function SoundManager.PlaySkillManager(soundIdx)
	-- body
	SoundManager.PlayerEffect(SoundEvent.Sound_skill,soundIdx)
end

--设置音量和音效--
function SoundManager.setMusicVolume(volume)
	-- body
	audio.setMusicVolume(volume)
end

function SoundManager.setEffectsVolume(volume)
	-- body
	audio.setSoundsVolume(volume)
end