import 'package:sound_sphere/data/models/artist.dart';
import 'package:sound_sphere/data/models/genres.dart';
import 'package:sound_sphere/data/models/user_playlist.dart';
import 'package:sound_sphere/data/models/radio.dart';
import 'package:sound_sphere/data/models/search_category.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/data/models/album.dart';

class FakeData {
  static void initialize() {
    gnxTracks.add(
      Track(
        id: "1",
        title: "wacced Out Murals ",
        artist: KendrickLamar,
        album: gnx,
        duration: "3:41",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfG9cjCeLfsyopSSTTyA5M8BTDY_Lgj5vN-A&s",
        lyrics: '''[id: dusfebhc]
[ar: Kendrick Lamar]
[al: GNX]
[ti: wacced out murals]
[length: 05:17]
[00:01.97]Siento aquí tu presencia
[00:07.78]La noche de anoche
[00:11.98]Y nos ponemos a llorar
[00:24.34]Yesterday, somebody whacked out my mural
[00:26.74]That energy'll make you niggas move to Europe
[00:29.81]But it's regular for me, yeah, that's for sure
[00:32.78]The love and hate is definite without a cure
[00:35.34]All this talk is bitch-made, that's on my Lord
[00:38.33]I'll kill 'em all before I let 'em kill my joy
[00:41.61]I done been through it all, what you endure?
[00:44.33]It used to be fuck that nigga, but now it's plural
[00:47.02]Fuck everybody, that's on my body
[00:49.90]My blick first, then God got me
[00:53.26]I watch 'em pander with them back-handed compliments
[00:56.26]Put they head on a Cuban link as a monument
[00:59.07]I paid homage and I always mind my business
[01:01.94]I made the—
[01:04.98]I never lost who I am for a rap image
[01:08.26]It's motivation if you wonder how I did it
[01:10.54]Yeah, nigga, go and up your rank
[01:13.44]Know you a god even when they say you ain't
[01:16.27]Yeah, nigga, keep your feelings out the way
[01:19.31]Never let no one put smut up on your name
[01:22.23]Yeah, nigga, keep your head down and work like I do
[01:25.27]But understand everybody ain't gon' like you
[01:28.11]Yeah, nigga, if they say it's love, you've been lied to
[01:31.18]A couple rules of engagements, I'ma guide you
[01:35.58]Que refleja en tu mirada
[01:39.51]La noche, tú y yo
[01:43.07]Ridin' in my GNX with Anita Baker in the tape deck, it's gon' be a sweet love
[01:47.70]Fuck apologies, I wanna see y'all geeked up
[01:51.20]Don't acknowledge me, then maybe we can say it's fair
[01:54.32]Take it to the internet and I'ma take it there
[01:56.82]Miss my uncle Lil' Mane, he said that he would kill me if I didn't make it
[02:00.35]Now I'm possessed by a spirit and they can't take it
[02:03.68]Used to bump Tha Carter III, I held my Rollie chain proud
[02:06.19]Irony, I think my hard work let Lil Wayne down
[02:08.95]Whatever, though, call me crazy, everybody questionable
[02:11.83]Turn me to an eskimo, I drew the line and decimals
[02:14.82]Snoop posted "Taylor Made," I prayed it was the edibles
[02:17.67]I couldn't believe it, it was only right for me to let it go
[02:20.63]Won the Super Bowl and Nas the only one congratulate me
[02:23.59]All these niggas agitated, I'm just glad they showin' they faces
[02:26.55]Quite frankly, plenty artists, but they outdated
[02:29.40]Old-ass flows, tryna convince me that you they favorite
[02:32.47]This is not for lyricists, I swear it's not the sentiments
[02:35.27]Fuck a double entendre, I want y'all to feel this shit
[02:38.27]Old soul, bitch, I probably built them pyramids
[02:41.22]Ducking strays when I rap battled in the Nickersons
[02:44.23]Where you from? Not where I'm from, we all indigenous
[02:46.91]Against all odds, I squabbled up for them dividends
[02:49.95]Against all odds, I showed up as a gentleman
[02:52.82]I done lost plenty friends, sixteen to be specific
[02:55.82]Put that on my kids' children, we gon' see the future first
[02:58.82]They like, "Dot big trippin," I just want what I deserve
[03:01.82]What bridge they done burnt? All of them, it's over with
[03:04.42]I'm doin' what COVID did, they'll never get over it
[03:08.19]Yeah, nigga, go and up your rank
[03:10.70]Know you a god even when they say you ain't
[03:13.34]Yeah, nigga, keep your feelings out the way
[03:16.73]Never let no one put smut up on your name
[03:19.14]Yeah, nigga, keep your head down and work like I do
[03:22.42]But understand everybody ain't gon' like you
[03:25.26]Yeah, nigga, if they say it's love, you've been lied to
[03:28.37]A couple rules of engagements, here to guide you
[03:31.13]Niggas from my city couldn't entertain old boy
[03:33.90]Promisin' bank transactions and even bitcoin
[03:37.07]I never peaced it up, that shit don't sit well with me
[03:39.94]Before I take a truce, I'll take 'em to Hell with me
[03:42.70]If that money got in the hands of a crash dummy
[03:45.66]Could jeopardize my family and burden the ones who love me
[03:48.74]Niggas mad 'cause I decided not to pretend
[03:51.66]Y'all stay politically correct, I'ma do what I did
[03:54.38]Ain't no sympathy here, this shit's hilarious
[03:57.26]It's a lot of opinions, but no power to carry it
[04:00.06]2025, they still movin' on some scary shit
[04:03.10]Tell 'em quit they job and pay the real niggas they severance
[04:06.06]Don't insult my intelligence, I'm not just for the television
[04:08.90]Teleport to Bullets Road and dig up all my relatives
[04:11.89]Okay, nigga, let's settle it, these niggas been fake loyal
[04:14.66]Since y'all pandering to choose a side, let me do it for you
[04:17.78]Okay, fuck your hip-hop, I watched the party just die
[04:20.22]Niggas cackling about— while all of y'all is on trial
[04:23.18]Niggas thought that I was antisocial when I stayed inside of my house
[04:26.42]You better off to have one woman, everything tricky right now
[04:29.10]You niggas live in denial
[04:30.66]Ayy, fuck anybody empathetic to the other side, I vow
[04:33.78]A bitch nigga love bitch niggas, they exist with 'em in style
[04:36.58]Exterminate 'em right now
[04:38.34]Make Katt Williams and them proud, the truth 'bout to get loud
[04:40.81]No juice iniside of my cup, I sober up and knock 'em all off
[04:43.54]Don't let no white comedian talk about no Black woman, that's law
[04:46.38]I know propaganda work for them, and fuck whoever that's close to them
[04:49.43]The niggas that coon, the niggas that bein' groomed, slide on both of them
[04:52.54]You ever ate Cap'n Crunch and proceeded to pour water in it?
[04:55.31]Pulled over by the law, you ridin' dirty, so you can't argue with 'em?
[04:58.06]Then make it to be a star, bare your soul and put your heart up in it
[05:00.83]Well, I did
[05:01.95]Whacked the murals out, but it ain't no legends if my legend ends
[05:17.09]''',
        urlMedia:
            "https://stream.nct.vn/Unv_Audio542/WaccedOutMurals-KendrickLamar-16803196.mp3?st=hB_3_NB-S4mog4KfsuhVNQ&e=1743148045&a=1&p=0&r=a559843092eaa737fb8c982a162a2065&t=1742546903572",
      ),
    );
    gnxTracks.add(
      Track(
        id: "2",
        title: "squabble up",
        artist: KendrickLamar,
        album: gnx,
        duration: "3:41",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfG9cjCeLfsyopSSTTyA5M8BTDY_Lgj5vN-A&s",
        lyrics: '''[id: pshxutju]
[ar: Kendrick Lamar]
[al: GNX]
[ti: squabble up]
[length: 02:38]
[00:00.24]Diagnosed, I am
[00:04.52]Reincarnated
[00:05.77]I was stargazin'
[00:06.99]Life goes on, I need all my babies (gyah, gyah)
[00:09.67]Woke up, lookin' for the broccoli
[00:11.60]High key, keep a horn on me, that Kamasi
[00:13.88]IP ownership, the blueprint is by me
[00:16.16]Mr. Get Off, I get off at my feet
[00:18.59]When I hear music, it makes me dance
[00:23.05]You got the music, now is your chance
[00:27.63]A yeet nigga couldn't try me in a tri-state
[00:30.12]Buddy passed, but I give him splash 'til he hydrated
[00:32.48]Bounce out, know he spook town, eyes dilated
[00:34.77]I got the money in a pile, both gyrated
[00:37.35]I feel good, get the fuck out my face
[00:39.67]Look good, but she don't got no ties
[00:41.85]I walked in, walked out with the sides
[00:44.14]Man down, let me know what the prize
[00:46.71]What the fuck? I got hits, I got bucks, I got new paper cups
[00:50.56]I got friends, I got foes, but they all sitting ducks
[00:52.82]Here this turf can get crackin', double back like a deluxe
[00:55.58]50 deep, but it ain't deep enough
[00:57.54]Fuck a plea, they'll go beat him up
[00:59.89]Fallin' from my money tree, and it grow throughout the mud
[01:02.11]Spit a loogie at the camera, speed off, yeah, it's us
[01:05.04]I feel good, get the fuck out my face
[01:07.42]Look good, but she don't got no ties
[01:09.62]I walked in, walked out with the sides
[01:11.97]Man down, let me know what the prize
[01:14.07]Squabble up, squabble up, squabble up, squabble up
[01:18.86]Squabble up (mm-mm), squabble up (mm-mm)
[01:21.12]Squabble up (mm-mm), squabble up
[01:23.47]Hol' up (hol' up), where you from? (Where you from?)
[01:27.82]My bitch (my bitch), I'm finna go dumb (finna go dumb)
[01:32.29]Sideways (sideways), monster (monster) fever (fever)
[01:39.13]I'm on one (I'm on one)
[01:41.63]Thump, thump, thump, thump, thump, baby rockin' it
[01:43.97]Quid pro quo, what you want? 'Cause I'm watchin' it
[01:46.30]Work on the flow, let me know if you crockin' it
[01:48.51]Brodie won't go, but I know that he poppin' it
[01:50.82]It was woof tickets on sale 'til I silenced it
[01:53.12]Pipe down, young, get some hoes out politics
[01:55.53]Bitch with 'em and some bitch in 'em, that's a lot of bitch
[01:57.80]Don't hit 'em, he got kids with him, my apologies
[02:00.10]Ghetto child, he was blackin' out with the Smirnoff
[02:02.47]Yee-haw, we outside, boy, they 'bout to kill him off
[02:04.76]Blaps on blaps, it's a fact, this a brickerall
[02:07.04]Tell me why the fuck you niggas rap if it's fictional?
[02:09.31]Tell me why the fuck you niggas fed if you criminal?
[02:11.78]"Hey, Dot, can I get a drop?" I'm like, "Nigga, nah"
[02:13.92]Ace boon coon from the Westside to synagogue
[02:16.12]It's a full moon, let the wolves out, I've been a dog (ah!)
[02:18.65]I feel good, get the fuck out my face
[02:21.25]Look good, but she don't got no ties
[02:23.31]I walked in, walked out with the sides
[02:25.86]Man down, let me know what the prize
[02:28.08]Squabble up, squabble up, squabble up, squabble up
[02:32.64]Squabble up (mm-mm), squabble up (mm-mm)
[02:35.06]Squabble up (mm-mm), squabble up
[02:36.25]''',
        urlMedia:
            "https://stream.nct.vn/Unv_Audio542/SquabbleUp-KendrickLamar-16803197.mp3?st=bkbkcNxnB1Fp5SRGqDi7Sg&e=1743148228&a=1&p=0&r=fcc3a48f3df339063faa7de744c835cc&t=1742547035878",
      ),
    );
    gnxTracks.add(
      Track(
        id: "3",
        title: "luther",
        artist: KendrickLamar,
        album: gnx,
        duration: "3:41",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfG9cjCeLfsyopSSTTyA5M8BTDY_Lgj5vN-A&s",
        lyrics: '''[id: iuyflyav]
[ar: Kendrick Lamar & SZA]
[al: Kendrick Lamar]
[ti: luther]
[length: 02:58]
[00:09.76](If this world were mine)
[00:12.36]Hey, Roman numeral seven, bae, drop it like it's hot
[00:15.93]If this world was mine, I'd take your dreams and make 'em multiply
[00:19.38]If this world was mine, I'd take your enemies in front of God
[00:22.74]Introduce 'em to that light, hit them strictly with that fire
[00:26.90]Fah-fah, fah-fah-fah, fah-fah, fah
[00:33.22]Hey, Roman numeral seven, bae, drop it like it's hot
[00:36.84]If this world was mine, I'd take your dreams and make 'em multiply
[00:40.29]If this world was mine, I'd take your enemies in front of God
[00:43.85]Introduce 'em to that light, hit them strictly with that fire
[00:47.23]It's a vibe, do your dance, let 'em watch
[00:49.83]She a fan, he a flop, they just wanna kumbaya, nah
[00:53.78]In this world, concrete flowers grow
[00:57.15]Heartache, she only doin' what she know
[01:00.56]Weekends, get it poppin' on the low
[01:03.97]Better days comin' for sure
[01:05.83]If this world were-
[01:09.31]If it was up to me
[01:11.32]I wouldn't give these nobodies no sympathy
[01:14.74]I'd take away the pain, I'd give you everything
[01:19.46]I just wanna see you win, wanna see
[01:21.22]If this world were mine
[01:22.82]It go in (when you), out (ride it), do it real slow (slide)
[01:26.73]Baby, you a star, strike, pose
[01:30.22]When I'm (when you), with you (with me), everything goes (slow)
[01:33.77]Come and (put that), put that (on my), on my (titi), soul (soul)
[01:37.13]'Rari (red), crown (stack), wrist (stay), froze (really)
[01:40.74]Drip (tell me), pound (if you), on the way home (love me)
[01:44.23]In this world, concrete flowers grow
[01:47.69]Heartache, she only doin' what she know
[01:51.06]Weekends, get it poppin' on the low
[01:54.60]Better days comin' for sure
[01:56.35]If this world were-
[01:59.99]If it was up to me
[02:01.78]I wouldn't give these nobodies no sympathy
[02:05.28]I'd take away the pain, I'd give you everything
[02:09.89]I just wanna see you win, wanna see
[02:11.60]If this world were mine
[02:13.43]I can't lie, I trust you, I love you, I won't waste your time
[02:17.17]I turn it off just so I can turn you on
[02:19.86]I'ma make you say it loud
[02:22.46]I'm not even trippin', I won't stress you out
[02:25.82]I might even settle down for you, I'ma show you I'm a pro
[02:29.85]I'ma take my time and turn it off, just so I can turn you on, baby
[02:34.52]Weekends, get it poppin' on the low
[02:37.97]Better days comin' for sure (I know you're comin', I know you're comin' for)
[02:42.06]
[02:45.55]
[02:47.71](Better days)
[02:53.15](If this world were mine)
[02:55.09]''',
        urlMedia:
            "https://stream.nct.vn/Unv_Audio542/Luther-KendrickLamar-16803198.mp3?st=e_L_wtihItor02Ciw89-8A&e=1743144665&a=1&p=0&r=cef06894c5e2999b65e5efd97e1c9186&t=1742543801591",
      ),
    );
    gnxTracks.add(
      Track(
        id: "4",
        title: "man at the garden",
        artist: KendrickLamar,
        album: gnx,
        duration: "3:41",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfG9cjCeLfsyopSSTTyA5M8BTDY_Lgj5vN-A&s",
        lyrics: '''
[id: tvczgdlr]
[ar: Kendrick Lamar]
[al: GNX]
[ti: man at the garden]
[length: 03:53]
[00:32.29]Twice emotional stability
[00:33.76]A sound body and tranquility
[00:35.56]I deserve it all
[00:37.33]Like minds and less enemies
[00:38.85]Stock investments, more entities
[00:41.24]I deserve it all
[00:42.72]VVS, that's white diamonds
[00:43.97]GNX with the seat back reclinin', bitch
[00:46.38]I deserve it all
[00:47.70]Put my homes on the beachfront
[00:49.54]Flyin' private, what you eat for lunch?
[00:51.50]I deserve it all
[00:53.07]The respect and the accolades
[00:54.87]Lampin' on the island, watching Cast Away
[00:56.78]I deserve it all
[00:58.08]For every good nigga that passed away
[00:59.74]Sent 2.5 million on an average day
[01:01.60]I deserve it all
[01:03.63]Keep my name by the world leaders
[01:05.31]Keep my crowds loud inside Ibiza
[01:07.23]I deserve it all
[01:08.94]More money, more power, more freedom
[01:10.74]Everything Heaven allowed us, bitch
[01:12.34]I deserve it all
[01:15.02]Hm, I deserve it all
[01:21.86]Hm, I deserve it all
[01:28.48]All
[01:33.47]All
[01:34.99]'Cause my intentions was pure
[01:36.67]Even when you wasn't sure
[01:38.15]Even with every allure
[01:39.58]How much temptation you endured?
[01:41.84]You probably look for every cure
[01:43.23]I said I deserve it all
[01:45.12]I'm wakin' up at 6:00 a.m.
[01:46.99]Six miles a day, conditioning my win
[01:48.68]I said I deserve it all
[01:50.55]I'm showin' up as your friend
[01:51.77]Tellin' truths better than your next of kin
[01:53.65]I said I deserve it all
[01:55.55]I never ask for too much credit
[01:57.01]Seekin' validation just for the aesthetics, bitch
[01:59.46]I deserve it all
[02:00.91]I see you as a human first
[02:02.17]Even when you didn't understand your worth
[02:04.33]Bitch, I deserve it all
[02:06.09]It's innate to mind my business
[02:07.41]Writin' words, tryna elevate these children
[02:09.44]That's why I deserve it all
[02:11.42]Pray for those who prayed against me
[02:12.52]Every reason why my ancestors sent me
[02:14.66]Bitch, I deserve it all
[02:19.76]I deserve it all
[02:25.05]I deserve it all
[02:30.91]All
[02:36.38]All
[02:37.72]Put a smile on my mama
[02:39.39]Good health and good karma
[02:40.84]Yeah, she deserves it all
[02:42.32]One hunnid murals out in Compton
[02:44.58]Remember me, I kept my promise
[02:46.20]Yeah, we deserve it all
[02:47.50]A better life for my daughter
[02:49.42]Made my son take it further than his father
[02:51.33]Yeah, he deserves it all
[02:52.72]A close relationship with God
[02:54.40]Whisper to me every time I close my eyes
[02:56.49]He say, "You deserve it all"
[02:58.07]Keep these bitch niggas away from me
[02:59.96]Keep all my blessings faithfully
[03:01.25]Keep my essence contagious, that's okay with me
[03:03.02]I burn this bitch down, don't you play with me or stay with me
[03:05.78]I'm crashin' out right now, no one's safe with me
[03:07.52]I did it with integrity, and niggas still try hate on me
[03:10.42]Just wait and see, more blood be spillin', it's just paint to me
[03:13.15]Dangerously, nothin' changed with me, still got pain in me
[03:15.74]Flip a coin, want the shameless me or the famous me?
[03:18.11]How annoying does it angers me to know the lames can speak
[03:20.86]On the origins of the game I breathe, that's insane to me
[03:23.48]It's important, I deserve it all because it's mine
[03:26.04]Tell me why you think you deserve the greatest of all time, motherfucker
[03:32.77]I deserve it all
[03:38.15]I deserve it all
[03:41.50]''',
        urlMedia:
            "https://stream.nct.vn/Unv_Audio542/ManAtTheGarden-KendrickLamar-16803199.mp3?st=8U0MAf719WQMTl8Zbju6Rg&e=1743148346&a=1&p=0&r=def89b34241ee15123ab981369a478c0&t=1742547154588",
      ),
    );
    gnxTracks.add(
      Track(
        id: "5",
        title: "hey now (feat Dody6)",
        artist: KendrickLamar,
        album: gnx,
        duration: "3:41",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfG9cjCeLfsyopSSTTyA5M8BTDY_Lgj5vN-A&s",
        lyrics: '''[id: pshxutjo]
[ar: Kendrick Lamar]
[al: GNX]
[ti: hey now (feat. Dody6)]
[length: 03:38]
[00:04.06]Damn, baby
[00:09.10]I like it
[00:14.07]Damn
[00:17.43]Hm
[00:19.36]Hey now, say now, I'm all about my Yen
[00:21.26]Big face Buddha, get my peace from within
[00:23.91]Send the kites to all my dirties in the pen
[00:25.99]Let the honorary walk for the win, for the win
[00:28.33]You crash out, then you better break the backboard
[00:30.82]I got friends, hopin' that they make the tabloids
[00:33.27]You know the last one figured, he was Magneto
[00:35.52]You play God, you gon' get what you ask for
[00:37.93]We got the same twenty-four, what you mad for?
[00:40.25]I put a square on his back like I'm Jack Dorsey
[00:42.73]It's high beams if I make a public appearance
[00:45.19]Go back to hidin', 'cause I'm not too friendly with—
[00:47.29]One, one thousand, two, one thousand, four
[00:49.69]The Black know I just strangled me a goat
[00:52.06]I walked in with a therapeutic flow
[00:53.96]Put a few hundred up, let 'em go, let 'em go
[00:56.93]Hey now, say now
[00:59.34]Hey now, say now
[01:01.64]Hey now, say now
[01:03.32]Hm, hey now, say now
[01:06.37]Hey now, say now, I'm all about my Yen
[01:08.28]Big face Buddha, get my peace from within
[01:11.00]Send the kites to all my dirties in the pen
[01:12.74]Let the honorary walk for the win, for the win
[01:15.71]Hey now, say now
[01:18.07]Hey now, say now
[01:20.46]Hey now, say now
[01:22.77]Hey now, say now
[01:24.77]Hey now, say now, I done slid on they backstreet
[01:27.33]Heavy on the Parmesan, every day tax season
[01:29.50]What the—you wearin'? Bro, it's tacky—
[01:32.13]Layin' on they deathbed, tryna match me
[01:34.20]Oh, my God, I'm 'bout to do the fool
[01:36.32]They be screamin' out "P", but they resume is boof
[01:38.83]Switch both lanes, the engine sound like the zoo
[01:41.04]Need a fee just to breathe, —I can't talk to you
[01:43.44]It's the Ben Frank murderer, Mister, I ain't heard of you
[01:46.01]Gulf streams, back to back, flyin' through the turbulence
[01:48.06]Who is he? Free lunch (hm) Kraft Services
[01:50.88]Throw your—out this rental, if I smell nervousness
[01:53.16]Hey now, say now, let me pop my—
[01:55.29]Water down my wrist, I'm around my—
[01:57.57]It's a green light, don't get out of bounds, I'ma blitz
[01:59.85]It's a bird, it's a plane, no, it's all blue strips
[02:02.28]—, what?
[02:02.84]Hey now, say now
[02:05.12]Hey now, say now
[02:07.42]Hey now, say now
[02:09.18]Hm, hey now, say now
[02:11.97]I'm way too important
[02:14.24]I'm way too important
[02:16.66]I'm way too important to ever let you slide on me again
[02:21.16]Startin' to see spaceships on Rosecrans (Startin' to see spaceships on Rosecrans)
[02:26.24]I seen the aliens hold hands (I seen the aliens hold hands)
[02:31.00]They wanna see me do my dance (They wanna see me do my dance)
[02:35.76]I let 'em watch me do my dance
[02:39.91]Who the—I feel like? I feel like Joker
[02:42.27]Harley Quinn, I'm in the cut with a blower
[02:43.93]Ayy, —get spooky every day in October
[02:46.68]My torpedo even jumped out on smokers, J-Cat
[02:48.61]Ayy, we mean muggin'—, Dody too important
[02:51.04]If they talkin' 'bout playin' ball, me and my team gon' get to scorin'
[02:53.42]If they talkin' 'bout playin' ball, they can take it up with Jordan
[02:55.81]It's bald heads and the hecklin' for all endorsements
[02:58.26]Eeny, meeny, miny, moe I'm tryna tag a—toe
[03:00.56]I'm aggressive on the beat and real life, —know
[03:02.75]Ayy, I tatted up my body, it depend, level four
[03:05.11]Ayy, I sharpened up a knife and came home to a blow
[03:07.47]My b- gon' get to tweakin' like she playin' with her nose
[03:09.82]Lil' brodie 'bout to crash, man, y'all—be on go
[03:12.29]I'm a different type of trophy, baby girl, I'm rose gold
[03:14.63]Me and Dot get to slidin', put 'em in a choke hold
[03:16.62]—actin' like some—actin' like some—
[03:19.17]Ayy, I jumped out that pan, then I jumped up in a Ghost
[03:21.59]I'm the hush type of—, see my face, then he froze
[03:24.00]All that shit he was talkin', found out he not that bold
[03:26.31]Okay, this shit like forty, that's a dub, okay, let's add it up
[03:28.82]Baby—fat, can you do it? Can you back it up?
[03:31.32]Kickflip a—, I got Tech Decks, and it ain't—for me to call and get your chin checked
[03:35.40]Tell 'em Dody did that
[03:36.49]''',
        urlMedia:
            "https://stream.nct.vn/Unv_Audio542/HeyNow-KendrickLamar-16803201.mp3?st=1neOavos2OKqKFq32mLi3Q&e=1743148444&a=1&p=0&r=9dc0196b99f71ffe38f0d6307b6b40cb&t=1742547250273",
      ),
    );
    gnxTracks.add(
      Track(
        id: "6",
        title: "reincarnated",
        artist: KendrickLamar,
        album: gnx,
        duration: "3:41",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfG9cjCeLfsyopSSTTyA5M8BTDY_Lgj5vN-A&s",
        lyrics: '''[id: pshxutjp]
[ar: Kendrick Lamar]
[al: GNX]
[ti: reincarnated]
[length: 04:36]
[00:00.23]Que reflejan tu mirada
[00:04.43]La noche, tú y yo
[00:20.64]I got this fire burnin' in me from within
[00:22.47]Concentrated thoughts on who I used to be, I'm sheddin' skin
[00:24.95]Every day, a new version of me, a third of me demented
[00:27.69]Cemented in pain, juggling opposing kinds of fame
[00:30.58]I don't know how to make friends, I'm a lonely soul
[00:32.63]I recollect this isolation, I was four years old
[00:35.56]Truth be told, I've been battling my soul, tryna navigate the real and fake
[00:39.01]Cynical about the judgement day
[00:40.78]I did bad, slight progression last year and it fucked me up
[00:43.88]Reincarnated on this earth for a hundred plus
[00:46.41]Body after body, lesson after lesson
[00:48.47]Let's take it back to Michigan in 1947
[00:51.20]My father kicked me out the house 'cause I wouldn't listen to him
[00:54.05]I didn't care about his influence, only loved what I was doing
[00:56.74]Gifted as a musician, I played guitar on the grand level
[00:59.65]The most talented where I'm from, but I had to rebel
[01:02.57]And so I'm off in the sunset, searchin' for my place in the world
[01:05.77]With my guitar up on my hip, that's the story unfurled
[01:08.34]I found myself with a pocket full of money, and a whole lot of respect
[01:11.77]While the record vendors loved me
[01:13.27]I was head of rhythm and blues
[01:14.98]The women that fell to they feet, so many to choose
[01:17.63]But I manipulated power, as I lied to the masses
[01:20.53]Died with my money, gluttony was too attractive, reincarnated
[01:34.48]Another life had placed me as a black woman in a chillin' circuit
[01:37.56]Seductive vocalist as the promoter hit the curtains
[01:39.82]My voice was angelic straight from heaven, the crowd sobbed
[01:42.67]A musical genius what the articles emphasized
[01:45.32]Had everything I wanted but I couldn't escape addiction
[01:47.86]Hair on needles had me in fetal position, restricted
[01:50.40]Turned on my family, I went wherever cameras be
[01:53.07]Cocaine, no private planes for my insanity
[01:55.93]Self-indulged, discipline never been my sentiments
[01:58.26]I needed drugs, to me, an eight-ball was like penicillin
[02:00.96]Fuck love, my happiness was in that brown sugar
[02:03.51]Sex and melodies gave me hope when nobody's lookin'
[02:06.29]My first assistant was a small-town scholar
[02:08.53]Never did a Quaalude 'til I got myself around her
[02:11.72]My daddy looked the other way, he saw sin in me
[02:14.37]I died with syringes pinched in me, reincarnated
[02:26.52]My present life is Kendrick Lamar
[02:28.13]A rapper looking at the lyrics to keep you in awe
[02:30.74]The only factor I respected was raising the bar
[02:33.34]My instincts sent material straight to the charts, huh
[02:36.79]My father kicked me out the house, I finally forgive him
[02:39.50]I'm old enough to understand the way I was livin'
[02:42.30]Ego and pride had me looking at him with resentment
[02:44.56]I close my eyes hoping that I don't come off contentious
[02:47.16]I'm yelling, "Father, did I finally get it right?" Everything I did was selfless
[02:50.73]I spoke freely when the people needed me, I helped them
[02:53.64]I didn't gloat even told them no when the vultures came took control
[02:57.04]Of my fleshly body when the money changed
[02:58.92]"Son you do well but your heart is closed
[03:01.17]I can tell residue that linger from your past creates itself"
[03:04.18]Father I'm not perfect I got urges, but I hold them down
[03:06.70]"But your pride has to die," okay father show me how
[03:09.24]Tell me every deed that you done and what you do it for
[03:11.90]I kept one hundred institutions paid, "Okay, tell me more"
[03:14.87]I put one hundred hoods on one stage, "Okay, tell me more"
[03:17.16]I'm tryna push peace in LA, "But you love war"
[03:19.97]No, I don't, "Oh, yes, you do," okay then tell me the truth
[03:22.47]"Every individual is only a version of you
[03:25.13]How can they forgive when there's no forgiveness in your heart?"
[03:27.80]I could tell you where I'm going, "I could tell you who you are"
[03:31.13]You fell out of heaven 'cause you was anxious
[03:33.30]Didn't like authority, only searched to be heinous
[03:35.82]Isaiah fourteen was the only thing that was prevalent
[03:41.83]My greatest music director was you
[03:43.34]It was colors, it was pinks, it was reds, it was blues
[03:46.04]It was harmony and motion
[03:47.41]I sent you down to earth 'cause you was broken
[03:49.56]Rehabilitation not psychosis
[03:51.48]But now we here now, centuries you manipulated man with music
[03:54.96]Embodied you as superstars to see how you moving
[03:57.79]You came a long way from garnishing evil-ish views
[04:00.27]And all I ever wanted from you was love and approval
[04:03.45]I learned a lot, no more putting these people in fear
[04:05.78]The more that word is diminished, the more it's not real
[04:08.14]The more light that I can capture, the more I can feel
[04:10.82]I'm using words for inspiration as an ideal
[04:13.92]"So can you promise that you won't take your gifts for granted?"
[04:16.28]I promise that I'll use my gifts to bring understanding
[04:18.77]"For every man, woman and child, how much can you vow?"
[04:21.34]I vow my life just to live one in harmony now
[04:23.86]"You crushed a lot of people keeping their thoughts in captivity"
[04:26.85]And I'm ashamed that I ever created that enemy
[04:29.54]Then let's rejoice where we at
[04:31.70]I rewrote the devil's story just to take our power back, 'carnated
[04:33.46]''',
        urlMedia:
            "https://a01.nct.vn/Unv_Audio542/Reincarnated-KendrickLamar-16803202.mp3?st=G9GssZtaXgD2qNTDXatyPQ&e=1743148533&a=1&p=0&r=08634b7e0563b0f0cd686c58f8d3d374&t=1742547338431",
      ),
    );
    gnxTracks.add(
      Track(
        id: "7",
        title: "tv off (feat. Lefty Gunplay)",
        artist: KendrickLamar,
        album: gnx,
        duration: "3:41",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfG9cjCeLfsyopSSTTyA5M8BTDY_Lgj5vN-A&s",
        lyrics: '''
[id: yvretajk]
[ar: Kendrick Lamar]
[al: GNX]
[ti: tv off (feat. Lefty Gunplay)]
[length: 03:41]
[00:04.88]All I ever wanted was a Black Grand National
[00:07.24]Fuck being rational, give 'em what they ask for
[00:11.12]It's not enough (Ayy)
[00:12.12]Few solid niggas left, but it's not enough
[00:14.48]Few bitches that'll really step, but it's not enough
[00:16.77]Say you bigger than myself, but it's not enough (Huh)
[00:19.44]I get on they ass, yeah, somebody gotta do it
[00:21.46]I'll make them niggas mad
[00:22.65]Yeah, somebody gotta do it
[00:23.74]I'll take the G-pass, shit, watch a nigga do it
[00:26.20]Huh, we survived outside, all from the music, nigga, what?
[00:30.36]They like, "What he on?"
[00:31.61]It's the Alpha and Omega bitch, welcome home
[00:35.08]This is not a song
[00:36.53]This a revеlation, how to get a nigga gone
[00:38.78]You need you a man, baby, I don't understand, baby
[00:40.72]Pay your bill and makе you feel protected like I can, baby
[00:43.04]Teach you somethin' if you need correction, that's the plan, baby
[00:45.62]Don't put your life in these weird niggas' hands, baby (Woah)
[00:48.01]It's not enough (Ayy)
[00:50.46]Few solid niggas left, but it's not enough
[00:52.76]Few bitches that'll really step, but it's not enough
[00:55.15]Say you bigger than myself, but it's not enough (Huh)
[00:58.21]I get on they ass, yeah, somebody gotta do it
[00:59.67]I'll make them niggas mad, yeah, somebody gotta do it
[01:02.22]I'll take the G-pass, shit, watch a nigga do it
[01:04.90]Huh, we survived outside, all from the music, nigga, what?
[01:08.73]Hey, turn this TV off
[01:09.73]Ain't with my type activities?
[01:10.97]Then don't you get involved
[01:12.19]Hey, what, huh, how many should I send? Send 'em all
[01:14.00]Take a risk or take a trip
[01:15.42]You know I'm trippin' for my dog
[01:16.92]Who you with? Couple sergeants and lieutenants for the get back
[01:19.12]This revolution been televised
[01:20.30]I fell through with the knick-knacks
[01:21.59]Hey, young nigga, get your chili up, yeah, I meant that
[01:23.96]Hey, black out if they act out, yeah, I did that
[01:28.26]Hey, what's up, though?
[01:28.94]I hate a bitch that's hatin' on a bitch and they both hoes
[01:31.21]I hate a nigga hatin' on them niggas and they both broke
[01:33.37]If you ain't coming for no chili, what you come for?
[01:36.21]Nigga feel like he entitled 'cause he knew me since a kid
[01:38.82]Bitch, I cut my granny off if she don't see it how I see it, hm
[01:40.94]Got a big mouth but he lack big ideas
[01:43.64]Send him to the moon, that's just how I feel, yelling
[01:45.91]It's not enough (Ayy)
[01:47.95]Few solid niggas left, but it's not enough
[01:50.28]Few bitches that'll really step, but it's not enough
[01:52.83]Say you bigger than myself, but it's not enough
[01:58.26]Huh
[01:59.65]Huh, huh
[02:02.29]Hey
[02:03.62]Hey (Mustard on the beat, ho)
[02:04.96]Mustard
[02:10.37]Niggas actin' bad, but somebody gotta do it
[02:11.66]Got my foot up on the gas, but somebody gotta do it
[02:13.86]Huh, turn this TV off, turn this TV off
[02:16.00]Huh, turn this TV off, turn this TV off
[02:18.87]Huh, turn this TV off, turn this TV off
[02:21.03]Huh, turn this TV off, turn this TV off
[02:23.90]Ain't no other king in this rap thing, like siblings
[02:25.98]Nothing but my children, one shot, they disappearin'
[02:28.25]I'm in a city with a flag
[02:30.12]Be gettin' thrown like it was pass interference
[02:31.90]Padlock around the building
[02:33.35]Crash, pullin' up in unmarked truck just to play freeze tag
[02:35.72]With a bone to pick like it was sea bass
[02:37.57]So when I made it out
[02:38.81]I made about fifty K from a show
[02:40.26]Tryna show niggas the ropes before they hung from a rope
[02:42.58]I'm prophetic, they only talk about it how I get it
[02:45.29]Only good for saving face, seen the cosmetics
[02:47.67]How many heads I gotta take to level my aesthetics?
[02:50.00]Hurry up and get your muscle up, we out the plyometric
[02:52.33]Nicarana by the lux, soon as I up the highest metric
[02:54.31]The city just made it sweet, you could die, I bet it
[02:57.21]They mouth get full of deceit, let these cowards tell it
[02:59.78]Walk in New Orleans with the etiquette of L.A., yelling
[03:01.80]Mustard (Ah, man)
[03:06.75]Niggas actin' bad, but somebody gotta do it
[03:08.75]Got my foot up on the gas, but somebody gotta do it
[03:11.35]Huh, turn this TV off, turn this TV off
[03:13.75]Huh, turn this TV off, turn this TV off
[03:16.08]Huh, turn this TV off, turn this TV off
[03:18.32]Huh, turn this TV off, turn this TV off
[03:21.02]Shit gets crazy, scary, spooky, hilarious
[03:23.03]Crazy, scary, spooky, hilarious
[03:25.58]Shit gets crazy, scary, spooky, hilarious
[03:27.93]Crazy, scary, spooky, hilarious
[03:30.20]Shit gets crazy, scary, spooky, hilarious
[03:32.52]Crazy, scary, spooky, hilarious
[03:34.63]Shit gets crazy, scary, spooky, hilarious
[03:37.48]Crazy, scary, spooky, hilarious
[03:39.77]''',
        urlMedia:
            "https://a01.nct.vn/Unv_Audio542/TvOff-KendrickLamar-16803203.mp3?st=TTj00M_i9EP08r8wedO3WQ&e=1743148633&a=1&p=0&r=ad6d0681dae8312fed6fcf19486c6c8f&t=1742547438900",
      ),
    );
    gnxTracks.add(
      Track(
        id: "8",
        title: "dodger blue (feat. Whallie the Sensei, Sietie7x & Roddy Ricch)",
        artist: KendrickLamar,
        album: gnx,
        duration: "3:41",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfG9cjCeLfsyopSSTTyA5M8BTDY_Lgj5vN-A&s",
        lyrics: '''[id: pshxuffd]
[ar: Kendrick Lamar]
[al: Kendrick Lamar Videos]
[ti: dodger blue (feat. Wallie the Sensei, Siete7x & Roddy Ricch)]
[length: 02:11]
[00:03.22]Ooh
[00:06.48]
[00:08.95]Ooh
[00:12.49]
[00:15.27]White diamonds, 2 a.m., she wildin'
[00:17.92]Bitches sick, got their stomach in her comments
[00:20.85]What school you went to? Gardena, Compton
[00:23.76]Westchester, King-Drew, then we function
[00:26.23]Lil' nigga, but that dog in me, that's on top
[00:29.48]On my kids, I'll sock you niggas up
[00:31.65]Have you ever took a fade and ran three more back to back?
[00:34.59]Oh, you haven't? Then shut the fuck up and keep it rap
[00:37.62]Gah, gah, gah
[00:39.14]Bitch, I'm from the Land
[00:40.58]Don't say you hate L.A. when you don't travel past the ten
[00:44.65]Am I trippin'? Yes, I am
[00:46.03]Meditate over some money, I see Franklin, I find zen
[00:50.73]Bitch, I'm from the Land
[00:51.99]Don't say you hate L.A., but live in L.A. and pretend
[00:55.25]My neck on Tarantino, Alejandro, Spike Lee
[00:58.06]Just know you took the scenic route if you stand by me, stupid
[01:01.97]So fly in this bitch
[01:03.62]50 on me, don't die tryin' and shit (ooh-ooh)
[01:06.41]You know I'm up and down when I slide in this bitch
[01:09.31]Dreamers and the Jets outside in this bitch
[01:12.24]Westside, get the money, yeah, that's fo' sho'
[01:15.17]Streets don't love you, better respect the code
[01:17.92]Ain't no sleepin' in on Sunday
[01:20.93]If it's 'bout the money, then my niggas on go
[01:23.43]When I walk in, oh yeah, bring that
[01:26.91]It's unanimous, how I pop shit
[01:29.28]When I walk in, hos better get in check
[01:32.63]You're lookin' at a bad bitch, nothin' less
[01:35.23]Walk, walk, walk, walk
[01:37.94]Walk, walk, walk, walk
[01:40.98]Tip, toe, pivot, walk
[01:43.86]Tip, toe, pivot, walk
[01:46.80]Ooh, don't take it personal
[01:51.54]You won't be the first to know
[01:54.30]Just might be the first to go
[01:57.17]Just might be, ooh
[02:00.08]Don't take it personal
[02:02.99]You won't be the first to know
[02:05.71]Just might be the first to go
[02:08.54]Just might be
[02:10.29]''',
        urlMedia:
            "https://a01.nct.vn/Unv_Audio542/DodgerBlue-KendrickLamar-16803204.mp3?st=HudRyq1C5iRUuA8Dj8E_RQ&e=1743148713&a=1&p=0&r=5562d09e0087beaedb19ccf6bb168922&t=1742547521607",
      ),
    );
    gnxTracks.add(
      Track(
        id: "9",
        title: "peakaboo",
        artist: KendrickLamar,
        album: gnx,
        duration: "3:41",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfG9cjCeLfsyopSSTTyA5M8BTDY_Lgj5vN-A&s",
        lyrics: '''[id: aairwbla]
[ar: Kendrick Lamar]
[al: GNX]
[ti: peekaboo (feat. AzChike)]
[length: 02:36]
[00:00.62]Give a helping hand
[00:04.72]To your fellow men, oh-oh, my
[00:12.14]A'ight, what?
[00:17.89]Look
[00:19.84]What they talkin' 'bout? They ain't talkin' 'bout nothin'
[00:21.38]What they talkin' 'bout? They ain't talkin' 'bout nothin'
[00:22.24]What they talkin' 'bout? They ain't talkin' 'bout nothin'
[00:23.54]What they talkin' 'bout? They ain't talkin' 'bout nothin'
[00:25.39]Huh? They ain't talkin' 'bout nothin'
[00:28.59]Hm, a'ight
[00:29.45]What they talkin' 'bout? They ain't talkin' 'bout nothin'
[00:30.74]What they talkin' 'bout? They ain't talkin' 'bout nothin'
[00:31.81]What they talkin' 'bout? They ain't talkin' 'bout nothin'
[00:33.03]What they talkin' 'bout? They ain't talkin' 'bout nothin'
[00:34.96]Huh? They ain't talkin' 'bout nothin', hm
[00:38.95]Peekaboo, how'd you put them boogers in my chain?
[00:41.45]Peekaboo, 80 pointers, like a Kobe game
[00:43.70]Peekaboo, 7.62s I'll make 'em plank
[00:46.16]Peekaboo, poppin' out, you better not smoke my name
[00:48.30]Peekaboo, put two foreigns on the 405
[00:50.69]Peekaboo, cacio e pepe if I'm doin' pasta
[00:53.16]Peekaboo, why you actin' tough on IG Live?
[00:55.78]Peekaboo, you know my lil'—off they rocker
[00:58.17]Peekaboo, surprise, —it's that—Chike E. Cheese
[01:00.52]Peekaboo, let me FaceTime my opp, —I'm up the street
[01:02.82]Peekaboo, yeah, it's Az, I'm puttin' somethin' to sleep
[01:05.28]Peekaboo, he on the ground, I praise God and start stompin' feet
[01:07.66]Peekaboo, I put ten on his face, —my shooter playin'
[01:10.04]Peekaboo, I hit it from the back, I told her move her hands
[01:12.66]Peekaboo, then slide—where her, uh, at
[01:14.91]Peekaboo, I'm on your top, I'm with Dot, —don't look back
[01:17.56]What they talkin' 'bout? They ain't talkin' 'bout nothin'
[01:18.78]What they talkin' 'bout? They ain't talkin' 'bout nothin'
[01:19.76]What they talkin' 'bout? They ain't talkin' 'bout nothin'
[01:20.96]What they talkin' 'bout? They ain't talkin' 'bout nothin'
[01:23.03]Huh? They ain't talkin' 'bout nothin', hm
[01:27.04]Hey, hey, hey, hey, hey, hey, hey, that's my—
[01:29.40]Hey, hey, hey, hey, hey, hey, hey, that's my—
[01:31.88]Hey, hey, hey, hey, with all that fake—
[01:34.24]Hey, hey, hey, hey, ain't the one to play with
[01:36.69]Hey, hey, hey, hey, hey, pull off in a Lamb'
[01:38.43]Double-park it all at Tam's, Mr. Get-Off-On-Your-Mans
[01:40.88]If he hatin', disrespect, you better follow up with hands
[01:43.61]Losses to the neck, but now I'm trophied up, I'm sayin', like
[01:46.16]Bing-bop-boom-boom-boom-bop-bam
[01:48.55]The type of—I'm on, you wouldn't understand
[01:51.06]The type of skits I'm on, you wouldn't understand
[01:53.32]Big dog business, I would not hold your hand
[01:55.75]Broke—business, I could not be your man
[01:57.73]Never got his—whooped until we open up that can
[02:00.42]Damn, alley-oop me bands, I'ma slam
[02:02.64]Gym freak—I like my MAC touchin' yams
[02:05.00]Pay the opps all around me, I'ma tell you, "Turn it off"
[02:07.30]Heard what happened to your mans, not sorry for your loss
[02:09.61]Should've prayed before them shooters came and nailed him to the cross
[02:12.22]I let your boy get a pass, —you lucky he soft, for real
[02:14.93]What they talkin' 'bout? They ain't talkin' 'bout nothin'
[02:16.29]What they talkin' 'bout? They ain't talkin' 'bout nothin'
[02:17.58]What they talkin' 'bout? They ain't talkin' 'bout nothin'
[02:18.68]What they talkin' 'bout? They ain't talkin' 'bout nothin'
[02:20.96]Huh? They ain't talkin' 'bout nothin', hm, a'ight
[02:24.70]What they talkin' 'bout? They ain't talkin' 'bout nothin'
[02:26.03]What they talkin' 'bout? They ain't talkin' 'bout nothin'
[02:27.24]What they talkin' 'bout? They ain't talkin' 'bout nothin'
[02:28.47]What they talkin' 'bout? They ain't talkin' 'bout nothin'
[02:30.19]Huh? They ain't talkin' 'bout nothin', hm
[02:33.98]Peekaboo
[02:34.41]''',
        urlMedia:
            "https://stream.nct.vn/Unv_Audio542/Peekaboo-KendrickLamar-16803205.mp3?st=-KzXA-K59vAZ8hJBHDbnbA&e=1743149031&a=1&p=0&r=5c768abb85b85f74c06a3c5a6a479c96&t=1742547838782",
      ),
    );
    gnxTracks.add(
      Track(
        id: "10",
        title: "heart pt. 6",
        artist: KendrickLamar,
        album: gnx,
        duration: "3:41",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfG9cjCeLfsyopSSTTyA5M8BTDY_Lgj5vN-A&s",
        lyrics: '''
[id: pshxutja]
[ar: Kendrick Lamar]
[al: GNX]
[ti: heart pt. 6]
[length: 04:52]
[00:23.30]Load up the Pro Tools and press three
[00:25.50]Studio filled with Jack In The Box and Pepsis
[00:28.32]Niggas watchin' Worldstar videos, not the ESPYs
[00:31.23]Laughin' at B Pump, her stomach turnin', I get up and proceeded to write somethin'
[00:35.63]Ab-Soul in the corner mumblin' raps, fumblin' packs of Black & Milds
[00:39.69]Crumblin' Kush 'til he cracked a smile
[00:41.78]His words legendary, wishin' I could rhyme like him
[00:44.77]Studied his style to define my pen
[00:47.06]That was back when the only goal was to get Jay Rock through the door
[00:50.10]Warner Brother Records, hope Naim Ali would let us know
[00:53.13]Was excited just to go to them label meetings
[00:55.84]Wasn't my record deal, but still, I couldn't believe it
[00:58.57]Me and Rock inside the booth, hibernatin'
[01:01.09]It was simple math, if he made it, that mean I made it
[01:03.98]Everything I had was for the team, I remained patient
[01:06.80]Grindin' with my brothers, it was us against them, no one above us, bless our hearts
[01:11.59]Use your heart and not your eyes (baby, just relax and ride)
[01:17.06]If you got time and I got time (yeah, yeah)
[01:22.95]Free your thoughts and watch them fly
[01:28.80]Use your heart and not your eyes (mm)
[01:34.89]My nigga Dave had a champagne Acura
[01:37.14]A bunch of instrumentals I freestyled in the passenger
[01:39.81]That nigga wore several hats, a producer, a manager, director, and DJ
[01:43.97]A hothead squabblin', Bloods, Pirus, and Keeways
[01:46.99]For this little thing of ours, we called TDE
[01:49.77]I watch you take some penitentiary chances to say the least
[01:52.80]Remember in the county buildin' with MixedByAli
[01:55.64]We tried to freak the system just to make a couple ends meet
[01:58.71]That's my nigga for shit sure
[02:00.71]He brought Q over, but Q didn't rap, but he learned from our inspo
[02:04.50]We split Louisiana chicken riverboat special
[02:07.51]Sleepin' next to 02R consoles to be our refuge
[02:10.82]He was homeless and I left home
[02:12.80]Q said, "Dot, you won't be slept on, you the nigga to bet on (use your h-)
[02:16.93]Top had given us the million in the home lived in
[02:19.36]Hopin' that we see some millions, God bless our hearts
[02:22.80]Use your heart and not your eyes (baby, just relax and ride)
[02:28.22]If you got time and I got time (yeah, yeah)
[02:34.23]Free your thoughts and watch them fly
[02:40.15]Use your heart and not your eyes
[02:46.03]Punch played Phil Jackson in my early practices
[02:48.96]Strategies on how to be great amongst the averages
[02:52.00]I picked his brain on what was ordained, highly collaborative
[02:54.99]Rep pushed the label the same, amongst the savages
[02:57.85]Moose kept my name in the function that he would run in
[03:00.89]TEEZ kept the vultures away from me that was comin'
[03:03.99]Sounwave let me borrow his clothes for shows
[03:06.66]As a hype man, to cook up in this room 'til the night ends
[03:09.74]Time flies, I'm carryin' debates of a top five
[03:12.65]Buryin' my opps and allies
[03:15.05]But I'd done a half job communicatin' feelings of bein' stagnant
[03:18.45]Life was gettin' bigger than just rappin'
[03:20.79]The bidness, what I was lackin'
[03:22.45]Top used to record me back when it was poor me
[03:25.22]And now we at the round table for what assures me
[03:28.18]I guess my motivation was the yearnin' for independence
[03:31.32]Poured everything I had left in the family bidness
[03:34.22]Now it's about Kendrick, I wanna evolve, place my skillset as a Black exec'
[03:38.95]I jog my memory, knowin' Black Hippy didn't work 'cause of me
[03:42.47]Creatively, I moved on, with new concepts in reach
[03:45.57]Top, remember all them sessions we would strategize?
[03:48.19]To hit the streets, then come back record three records, ah
[03:51.38]To tell the truth, it fucked me up when D-Man passed
[03:54.32]The motive was the condolences, but the pride crashed
[03:57.43]I had to bypass old mythologies, I had
[04:00.59]Put my heart on display like it was an iMac
[04:03.08]To all my young niggas, let me be the demonstration
[04:06.01]How to conduct differences with a healthy conversation
[04:09.11]If that's your family, then handle it as such
[04:11.76]Don't let the socials gas you up, or let emotions be your crutch
[04:14.53]Pick up the phone and bust it up before the history is lost
[04:17.56]Hand-to-handshake is good when you have a heart-to-heart
[04:20.42]Use your heart and not your eyes (baby, just relax your mind)
[04:26.55]If you got time and I got time (yeah, yeah)
[04:32.55]Free your thoughts and watch them fly
[04:38.48]Use your heart and not your eyes (hmm-hmm-hmm-hmm-hmm-hmm)
[04:46.07]''',
        urlMedia:
            "https://a01.nct.vn/Unv_Audio542/HeartPt6-KendrickLamar-16803206.mp3?st=lYrw7zYN14VjAkQSNVCJnw&e=1743148871&a=1&p=0&r=83e9c5df07f2423fbc70e5c3a9f251a9&t=1742547677843",
      ),
    );
    gnxTracks.add(
      Track(
        id: "11",
        title: "gnx (feat. Hitta J3, YoungThreat & Peysoh)",
        artist: KendrickLamar,
        album: gnx,
        duration: "3:41",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfG9cjCeLfsyopSSTTyA5M8BTDY_Lgj5vN-A&s",
        lyrics: '''
[id: pshxutjs]
[ar: Kendrick Lamar]
[al: GNX]
[ti: gnx (feat. Hitta J3, YoungThreat & Peysoh)]
[length: 03:14]
[00:12.62]Tell 'em Kendrick did it, ay, who showed you how to run a blitz?
[00:15.18]Tell 'em Kendrick did it, who put the West back in front of—?
[00:17.83]Tell 'em Kendrick did it, ayy I'm trippin' and I'm lovin' it
[00:20.68]Tell 'em Kendrick did it, like, wha
[00:24.35]Hi, have you ever been a joint and you know it?
[00:27.73]Have you ever had to flip your unemployment?
[00:30.37]On the dead guys, —I ain't goin'—
[00:32.98]Ayy, on the dead ones
[00:35.15]We'll treat an enem- like some bread crumbs
[00:37.66]All of my killers on go, like, who said somethin'?
[00:40.06]Redrum, all I think about when I see heads come
[00:43.05]Do my dance, hit the chop when I see opps go
[00:45.76]Let 'em claim it, we the ones who really pop, bro
[00:48.22]Don't televise it, we the ones who lettin' chops blow
[00:50.79]Opps know, let 'em piss him off and it's a flop show
[00:53.33]Murder man, singin' murder music off a murder van
[00:56.15]Beat the—up like I been celibate and I murder sound
[00:58.74]Who is him? One and only shotta, known as murder man
[01:01.28]Catch you doin' dirty, it's no other way but the murder plans
[01:04.33]I broke her heart and you the type to go and fix it
[01:06.92]Don't wanna speak if you ain't talkin' 'bout no ticket
[01:09.54]I'm bougie with it, but I might just let you kiss it
[01:11.50]Hit that block with diamonds on me, you could tell 'em Peysoh did it
[01:16.98]Tell 'em Peysoh did it, ay, who showed you how to run a blitz?
[01:19.38]Tell 'em Peysoh did it, who put the West back in front of—?
[01:21.82]Tell 'em Peysoh did it, ayy I'm trippin' and I'm lovin' it
[01:24.63]Tell 'em Peysoh did it, like, wha
[01:28.42]Hi, have you ever been a joint and you know it?
[01:31.71]Have you ever had to flip your unemployment?
[01:34.49]On the dead guys, —I ain't goin'
[01:36.21]How 'bout suicide doors, it's the Hitta, man
[01:38.53]You don't wanna see them doors slidin' on the Caravan
[01:41.27]I know killers who was catchin' bodies and not one fade
[01:43.95]I was 13 up at Avalon, poppin' chains
[01:46.52]14, ridin' minibikes with some dead friends
[01:49.22]21 flag on my head like a Taliban
[01:51.88]25, feelin' like the box, it was full of sand
[01:54.69]At the cemetery, —up that's where I could've been
[01:57.00]142nd, I'm connected like I'm Rosecrans
[01:59.73]Kinda—I seen, try and forget and I will pop a Xan'
[02:02.46]Uppin' scores, doin' files, sacrifices like a boxing ring
[02:05.46]Can't throw in the towel, pistol-packin' since a child
[02:08.39]Ayy, like it's Iraq, shooter name Hussein
[02:11.32]Ridin' with the dirty blicky, switchy, make a new flame
[02:13.88]She said I been a dog all my life, bae, can you change?
[02:16.58]True to my religion, Cuban links, more than two chains
[02:20.76]Tell 'em Hitta did it, ay, who showed you how to run a blitz?
[02:23.24]Tell 'em Hitta did it, who put the West back in front of—?
[02:25.83]Tell 'em Hitta did it, ayy I'm trippin' and I'm lovin' it
[02:30.14]It's gettin' down to the wire
[02:31.67]Get on my Bob the Builder—, get down with the pliers
[02:34.36]Been comin' back-to-back hits, how this—ain't tired?
[02:36.99]I'm with some rockstar—, they want Lizzie McGuire
[02:40.18]I'm switchin' gears, I pop the clutch, I'll send a—
[02:43.03]A risk-taker, I'll call you—bluff
[02:45.06]If they hangin' out for real, we come deduct
[02:47.20]Tuckin' tails, they out of luck
[02:48.47]When it's wartime, they hidin' in the cut
[02:51.18]Y'all had y'all chance, y'all couldn't do it
[02:52.61]I swear I'm comin' worse than y'all baby moms
[02:54.77]I'm puttin'—through it
[02:56.50]They hate to see me doin' it
[02:59.25]Meal ticket, I'm pursuin' it
[03:00.84]I'm in the field for real, UCLA Bruins
[03:03.25]They askin' how I do it, how a young—so fluent
[03:06.07]I kept my mouth closed and I ain't never leave no witness
[03:08.47]D.O.A. up on the scene, tell 'em YoungThreat did it, —
[03:11.64]''',
        urlMedia:
            "https://stream.nct.vn/Unv_Audio542/Gnx-KendrickLamar-16803851.mp3?st=yShSh1_pQuSUgOjuYnsLlA&e=1743148923&a=1&p=0&r=8f9ba9791126e897d19d6b365593a67d&t=1742547728555",
      ),
    );
    gnxTracks.add(
      Track(
        id: "12",
        title: "gloria",
        artist: KendrickLamar,
        album: gnx,
        duration: "3:41",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfG9cjCeLfsyopSSTTyA5M8BTDY_Lgj5vN-A&s",
        lyrics: '''[id: pshxgfis]
[ar: Kendrick Lamar & SZA]
[al: 4:48]
[ti: gloria]
[length: 04:48]
[00:00.01]Sentado
[00:02.99]Anita y tú
[00:06.84]
[00:18.10]Me and my bitch got a complicated relationship
[00:21.15]She's so controllin', I noticed it ain't no playin' with
[00:24.45]I met her when I was off the porch as a teenager
[00:28.15]She said one day I would right my wrongs and see paper
[00:31.55]We started out young, lookin' for some identity
[00:34.78]Made a thousand mistakes, but never did we lack chemistry
[00:38.22]Wrappin' my hand 'round your waist
[00:40.02]That was back when you did whatever I say
[00:42.53]Dreams of sellin' narcotics, runnin' blocks, or robbin' banks
[00:46.08]I was in love with you, didn't know what it was with you
[00:49.43]Kiss you in back of the class just to get a buzz with you
[00:52.80]Some niggas wanted you, but they weren't committed
[00:55.52]Preoccupied playin' John Madden and bullshittin'
[00:58.83]Remember when granny died? You looked at me and said
[01:02.08]"Baby, dry your eyes, depend on me as your relief
[01:05.28]Let your anger be mine," we was locked in ever since then
[01:09.25]So territorial, even took me 'way from my friends, hm, hm
[01:15.99]Scared of forever, you know nothin' else is gon' pass
[01:22.43]I just gotta let you know, woah
[01:29.47]Whenever you want me, you got me 'til the end of time
[01:34.36]Ooh, just gotta let you know
[01:40.35]Said you gon' see other people if I didn't grow with you
[01:43.53]Wasn't no more holdin' them pistols in front of stores with you
[01:46.95]You want reality, not tragedy, for sure, I get you
[01:50.34]To tell the truth, I been pretty used to what open-minded people do
[01:54.30]In 2014, I went to Africa, baby, you was my passenger
[01:58.36]My eyes and ears for all the years the neighborhood had baffled us
[02:01.87]Of course I had to wrap it up, I didn't fully trust you
[02:05.31]Fabrication, I disgust you, then you blocked me, I said, "Fuck you"
[02:08.78]Nigga, what? I gave you life
[02:11.65]I breathe the motherfuckin' charisma in this bitch
[02:13.81]I bring the blessings, I gave you power
[02:16.13]Nigga, I bring the rainfall, I gave you hustle
[02:19.31]Then fall right back and love the very moment that I touch you
[02:24.57]Scared of forever, you know nothin' else is gon' pass
[02:29.69]I just gotta let you know
[02:34.50]
[02:38.09]Whenever you want me, you got me 'til the end of time
[02:42.89]Ooh, just gotta let you know
[02:49.92]You were spontaneous, firecracker, plus our love is dangerous
[02:53.43]Life of passion, laughin' at you lose your temper, slightly crashin'
[02:57.08]Dumb enough to ill reaction, ain't no disrespect
[03:00.25]Highly sensitive, possess, so protect you, even when it's tragic
[03:03.74]So jealous, hate it when I hit the club to get some bitches
[03:07.20]Wrote 'em off, rather see me hit the church and get religious
[03:10.69]Who you foolin'? I know what you doin', you my contradiction
[03:14.32]'Member when you caught that body and still wiggled through that sentence?
[03:17.78]Loved you more, when you flip and lose your shit, I hugged you more
[03:21.15]It's sexy to me, cuss they ass out and hold that grudge some more
[03:24.52]Down bitch, I know your favorite movie, is it Notebook?
[03:27.91]So good, if they all sub me, get 'em all booked
[03:31.22]My baby boo, you either heal niggas or you kill niggas
[03:34.89]Both is true, it take some tough skin just to deal with you
[03:38.17]Logical explanation don't exist, flippin' pages
[03:41.65]Chapter after chapter, probably remarry and head to Vegas
[03:45.04]Bitches gettin' marked out, they can't erase our history
[03:48.31]They margins ain't big enough, they all led by bigotry
[03:51.85]My woman and my right hand, my saint and my sin
[03:54.90]Ain't no bitch like my bitch, 'cause that bitch been my pen
[03:58.98]Gloria, I wanna take you to euphoria
[04:03.46]Bitches want you, but they ain't strong enough
[04:07.68]I heard her talkin' we notorious
[04:10.54]It's so much, I can only
[04:12.68]I see you, you see me
[04:15.72]Both see what we want, oh, oh
[04:19.35]I see you, you see me
[04:22.66]Both see what we want
[04:24.31]''',
        urlMedia:
            "https://a01.nct.vn/Unv_Audio542/Gloria-KendrickLamar-16803208.mp3?st=_sJcTy5RGVn9EBRSEcqx4A&e=1743148999&a=1&p=0&r=622c730fb5e48b09a6821f6d6509d78d&t=1742547806039",
      ),
    );
  }

  // static AppUser user = AppUser(
  //   name: "Nguyen Dat Khuong",
  //   password: "1123",
  //   email: "zzkhngzz@gmail.com",
  //   avatarURL:
  //       "https://yt3.googleusercontent.com/oN0p3-PD3HUzn2KbMm4fVhvRrKtJhodGlwocI184BBSpybcQIphSeh3Z0i7WBgTq7e12yKxb=s900-c-k-c0x00ffffff-no-rj",
  // );
  List<Track> parseSongs(List<dynamic> jsonList) {
    return jsonList.map((json) => Track.fromJson(json)).toList();
  }

  // Regex to match timestamps and lyrics
  static RegExp regExp =
      RegExp(r'\[(\d+):(\d+\.\d+)\](.*?)((?=\[\d+:\d+\.\d+\])|$)');

  static List<SearchCategory> searchCategory = [
    SearchCategory(
        name: "SoundSphere Music Live",
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4M1UzKpmdpmBuA9GT1f-vTmdwm64u4RNtGA&s"),
    SearchCategory(
        name: "Vietnamese Music",
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrH7labPAP-FcsZQFXpdeXF_BRrYluKuKd4w&s"),
    SearchCategory(
        name: "K-Pop",
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeeCMPJmpq8ufdWx96rNfsfqMxrnRX0GHZ1A&s"),
    SearchCategory(
        name: "Pop",
        imageUrl:
            "https://variety.com/wp-content/uploads/2020/01/taylor-swift-variety-cover-5-16x9-1000.jpg?w=1000&h=563&crop=1"),
    SearchCategory(
        name: "Charts",
        imageUrl:
            "https://media.gq.com/photos/56bb8a91b89407780bd7d454/16:9/w_2560%2Cc_limit/bieber-16-9-longform.jpg"),
    SearchCategory(
        name: "Hits",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Spatial Audio",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Live Music",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "DJ Mixes",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Essential",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Classical",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Acoustic",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Sleep",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Chill",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Feeling Blue",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Focus",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Romance",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Party",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Wellbeing",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Fitness",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "2010s",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "'90s",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "'80s",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Hip-Hop/Rap",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Rock",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Dance",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Electronic",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Country",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Jazz",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
  ];
  // ignore: non_constant_identifier_names
  static Artist KendrickLamar = Artist(
      id: "Kendrick Lamar",
      name: "Kendrick Lamar",
      avatarURL:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx8935i5xXzUD5jhdcyxMWoCqxAO8mm6U7jw&s");
  static List<Track> gnxTracks = [];
  static Album gnx = Album(
      title: "GNX",
      aritst: KendrickLamar,
      genre: Genres(
          name: "Hip Hop",
          imgURL:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfG9cjCeLfsyopSSTTyA5M8BTDY_Lgj5vN-A&s"),
      tracks: gnxTracks,
      imgURL:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfG9cjCeLfsyopSSTTyA5M8BTDY_Lgj5vN-A&s",
      releaseDate: "2021-01-01");

  static List<String> chrismastPlaylistImg = [
    "https://assets.editorial.aetnd.com/uploads/2009/10/christmas-trees-gettyimages-1072744106.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFc9Sg5PxoxYxi-VIQfA6UU58Kr_T9Ekv0qg&s",
    "https://www.shutterstock.com/image-photo/beautiful-christmas-holiday-frame-tree-600nw-2381173013.jpg",
  ];

  static List<String> newYearPlaylistImg = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw6juTTwcRX498vxuvlxk6OtYndwdCjVwrzSJj5cEnzmEyfjjtsgi8wLAKdvFwHBR8Lr8&usqp=CAU",
    "https://img.freepik.com/free-vector/flat-new-year-s-eve-celebration-illustration_23-2149853861.jpg",
    "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/a8e59f47383181.5f80a5fa5dc72.jpg",
  ];

  static List<Genres> moodList = [
    Genres(name: "Happy", imgURL: "https://example.com/happy.jpg"),
    Genres(name: "Sad", imgURL: "https://example.com/sad.jpg"),
    Genres(name: "Angry", imgURL: "https://example.com/angry.jpg"),
    Genres(name: "Focus", imgURL: "https://example.com/focus.jpg"),
    Genres(name: "Chill", imgURL: "https://example.com/chill.jpg"),
    Genres(name: "Relax", imgURL: "https://example.com/relax.jpg"),
    Genres(name: "Workout", imgURL: "https://example.com/workout.jpg"),
    Genres(name: "Study", imgURL: "https://example.com/study.jpg"),
    Genres(name: "Party", imgURL: "https://example.com/party.jpg"),
    Genres(name: "Sleep", imgURL: "https://example.com/sleep.jpg"),
    Genres(name: "Work", imgURL: "https://example.com/work.jpg")
  ];

  static List<String> locationList = [
    "Global",
    "VietNam",
    "Canada",
    "Australia",
    "France",
    "Gremany",
    "Japan",
    "Korea",
    "China",
    "Russia",
    "Brazil",
    "India",
    "Italy",
    "Spain",
    "Mexico"
  ];
  static List<Map<String, String>> locationImages = [
    {
      "location": "New York",
      "imageURL":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmUhi0s72FfDSznKL39WrbN3VW6sr31F27zw&s"
    },
    {
      "location": "Can Tho",
      "imageURL":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIcLaH_ZFE8kG9VVDBdm3-r0CH2t8WvLgYpg&s"
    },
    {
      "location": "Los Angeles",
      "imageURL":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRW6srZopstrWRUc-pxrEZ_x7pSF7ydd2aAdg&s"
    },
    {
      "location": "Houston",
      "imageURL":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7uVn9qmYCa967nuUo6PUfARVECZanqazemw&s",
    },
    {
      "location": "Phoenix",
      "imageURL":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNqIE45c3XRwsEzpcswNwJy7yhZDseTCv5IA&s",
    },
    {
      "location": "London",
      "imageURL":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNLhqqEOOBzvZ44xKRuDR_bVEtpsMLWGh78Q&s",
    },
    {
      "location": "Birmingham",
      "imageURL":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRRUa9zhSNLH3ulQ7QJBpfjDbMfwYeSrxYdQ&s",
    },
    {
      "location": "Ha Noi",
      "imageURL":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMi91oQxfjS7xU5gHFszaqRmM4eyYNKpN8Sg&s",
    },
    {
      "location": "Ho Chi Minh",
      "imageURL":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdFxSCeRP_GVEn6nNG7uc09oSInbOK54aMng&s",
    },
  ];
  static List<RadioStation> radioList = [
    RadioStation(
        name: "Music 1",
        image:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUmoCjYlwBy4UahDRUDth5yAW0ibgspq4ddA&s",
        description: "Tommorow's hits today"),
    RadioStation(
        name: "Music Country",
        image:
            "https://www.apple.com/newsroom/images/product/apple-music/Apple_announces-apple-music-radio-country_08182020_inline.jpg.large.jpg",
        description: "Defining the country"),
    RadioStation(
        name: "Centery Hits",
        image:
            "https://www.apple.com/newsroom/images/product/apple-music/Apple_announces-apple-music-hits_08182020_inline.jpg.large.jpg",
        description: "Hits that change world"),
  ];

  static List<UserPlaylist> playlists = [
    UserPlaylist(
        id: "1",
        name: "Christmas Playlist",
        imgURL:
            "https://assets.editorial.aetnd.com/uploads/2009/10/christmas-trees-gettyimages-1072744106.jpg",
        tracks: []),
    UserPlaylist(
        id: "2",
        name: "Kendrick Lamar Essentials",
        imgURL:
            "https://assets.editorial.aetnd.com/uploads/2009/10/christmas-trees-gettyimages-1072744106.jpg",
        tracks: []),
    UserPlaylist(
        id: "3",
        name: "Celebrate Tet 2025",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw6juTTwcRX498vxuvlxk6OtYndwdCjVwrzSJj5cEnzmEyfjjtsgi8wLAKdvFwHBR8Lr8&usqp=CAU",
        tracks: []),
    UserPlaylist(
        id: "4",
        name: "Celebrate Tet 2025",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw6juTTwcRX498vxuvlxk6OtYndwdCjVwrzSJj5cEnzmEyfjjtsgi8wLAKdvFwHBR8Lr8&usqp=CAU",
        tracks: []),
    UserPlaylist(
        id: "5",
        name: "Celebrate Tet 2025",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw6juTTwcRX498vxuvlxk6OtYndwdCjVwrzSJj5cEnzmEyfjjtsgi8wLAKdvFwHBR8Lr8&usqp=CAU",
        tracks: []),
    UserPlaylist(
        id: "6",
        name: "Celebrate Tet 2025",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw6juTTwcRX498vxuvlxk6OtYndwdCjVwrzSJj5cEnzmEyfjjtsgi8wLAKdvFwHBR8Lr8&usqp=CAU",
        tracks: []),
    UserPlaylist(
        id: "7",
        name: "Celebrate Tet 2025",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw6juTTwcRX498vxuvlxk6OtYndwdCjVwrzSJj5cEnzmEyfjjtsgi8wLAKdvFwHBR8Lr8&usqp=CAU",
        tracks: []),
    UserPlaylist(
        id: "8",
        name: "Celebrate Tet 2025",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw6juTTwcRX498vxuvlxk6OtYndwdCjVwrzSJj5cEnzmEyfjjtsgi8wLAKdvFwHBR8Lr8&usqp=CAU",
        tracks: []),
  ];
  static List<Artist> artists = [
    Artist(
        name: "Adele",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrH7labPAP-FcsZQFXpdeXF_BRrYluKuKd4w&s"),
    Artist(
        name: "Beyoncé",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRG-ZLHpsb5TY_hTBkj-kof4swZ-g9fUS_Psj8M_4Pgs-R3_Cp9"),
    Artist(
        name: "Drake",
        avatarURL:
            "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQaooHw3BvR2onHwzNNugmr5cw0R5PE2XsGauTbxW_pJS9U7AGL"),
    Artist(
        name: "Ed Sheeran",
        avatarURL:
            "https://yt3.googleusercontent.com/emA0C_i9tUyJgxrfVpJ31e0QCU2MlovjYvQkAC9mDuSJyhl6h8PkFj5-ozRzz2vFtpbnls8s1W4=s900-c-k-c0x00ffffff-no-rj"),
    Artist(
        name: "Taylor Swift",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/Taylor_Swift_at_the_2023_MTV_Video_Music_Awards_4.png/1200px-Taylor_Swift_at_the_2023_MTV_Video_Music_Awards_4.png"),
    Artist(
        name: "Ariana Grande",
        avatarURL:
            "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSXEVN2qNzKweNSH_usXSeD4cU4k7DEtzLz7PVkLbNRPqiACcXS"),
    Artist(
        name: "Justin Bieber",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Billie Eilish",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "The Weeknd",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Post Malone",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Lady Gaga",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Katy Perry",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Bruno Mars",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "The Weeknd",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Post Malone",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Lady Gaga",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Katy Perry",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Bruno Mars",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "The Weeknd",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Post Malone",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Lady Gaga",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Katy Perry",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Bruno Mars",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "The Weeknd",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Post Malone",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Lady Gaga",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Katy Perry",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Bruno Mars",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "The Weeknd",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Post Malone",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Lady Gaga",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Katy Perry",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Bruno Mars",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "The Weeknd",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Post Malone",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Lady Gaga",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Katy Perry",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Bruno Mars",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
  ];

  static List<Genres> genres = [
    Genres(
        name: "Pop",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Pop_music.svg/1200px-Pop_music.svg.png"),
    Genres(
        name: "Rock",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/Electric_Guitar.png/1024px-Electric_Guitar.png"),
    Genres(
        name: "Hip Hop",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/Hip-hop_turntables.jpg/1024px-Hip-hop_turntables.jpg"),
    Genres(
        name: "Jazz",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Jazz_musicians_in_New_York.jpg/1024px-Jazz_musicians_in_New_York.jpg"),
    Genres(
        name: "Classical",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/Ludwig_van_Beethoven.jpg/800px-Ludwig_van_Beethoven.jpg"),
    Genres(
        name: "Country",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Country_music_legend.jpg/1024px-Country_music_legend.jpg"),
    Genres(
        name: "Electronic",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/Electronic_dance_music_festival.jpg/1024px-Electronic_dance_music_festival.jpg"),
    Genres(
        name: "Reggae",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/Reggae_Artist_Performance.jpg/1024px-Reggae_Artist_Performance.jpg"),
    Genres(
        name: "Blues",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/Blues_Singer.jpg/1024px-Blues_Singer.jpg"),
    Genres(
        name: "Metal",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Heavy_metal_performance.jpg/1024px-Heavy_metal_performance.jpg"),
    Genres(
        name: "Folk",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Folk_Music_Concert.jpg/1024px-Folk_Music_Concert.jpg"),
    Genres(
        name: "R&B",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/R%26B_Singer_2015.jpg/1024px-R%26B_Singer_2015.jpg"),
  ];

  List<String> paymentMethodImage = [
    "https://e7.pngegg.com/pngimages/530/165/png-clipart-logo-mastercard-pentagram-flat-design-brand-mastercard-text-trademark.png",
    "https://e7.pngegg.com/pngimages/618/512/png-clipart-visa-logo-mastercard-credit-card-payment-visa-blue-company.png",
    "https://cdn.prod.website-files.com/62b0e6308cc691625470b227/62dec0259f18b71442a15966_Apple-Logo.png"
  ];
  List<String> hiphopAlbumCover = [
    "https://images.prismic.io/rockthebells/524e2d10-3015-4098-b2a9-83de5cf70ee4_67ce3bba.jpg.webp?auto=compress,format",
    "https://townsquare.media/site/812/files/2023/03/attachment-astroworld.jpg?w=780&q=75",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSorV9huTZhlL6gztB4lF6o0WMu_STgaujjxg&s"
  ];

  List<String> popAlbumCover = [
    "https://www.billboard.com/wp-content/uploads/media/tyler-the-creator-igor-album-art-2019-billboard-embed.jpg?w=600",
    "https://www.bykerwin.com/wp-content/uploads/2022/09/Rolling-Stones-final-2022-BC.jpg",
    "https://i.cbc.ca/1.4678126.1527269930!/fileImage/httpImage/image.jpg_gen/derivatives/original_780/shawn-mendes.jpg"
  ];

  List<String> rbAlbumCover = [
    "https://www.revolt.tv/article/2024-02-18/351387/media_191666d5e27043a84a767bb6679f9d23e4f77cd98.jpeg?width=1200&format=pjpg&optimize=medium",
    "https://cdn.awsli.com.br/2197/2197610/produto/188239463/b356e4c654.jpg",
    "https://www.vibe.com/wp-content/uploads/2015/01/MCM3.jpg",
  ];

  List<String> rockAlbumCover = [
    "https://indieground.net/wp-content/uploads/2013/06/indieblog-best-album-covers-90s-11-1024x1024.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaELmha0Aaj78SsIUeNJOyCIPBdR5C1w_M9g&s",
    "https://www.billboard.com/wp-content/uploads/2022/03/35.-Metallica-%E2%80%98Master-of-Puppets-1986-album-art-billboard-1240.jpg?w=600"
  ];

  static List<Album> albums = [
    Album(
        title: "Đánh đổi",
        aritst: Artist.defaultArtist(),
        genre: genres[2],
        releaseDate: "2023",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        tracks: gnxTracks),
    Album(
        title: "Lemonade",
        aritst: Artist.defaultArtist(),
        genre: genres[2],
        releaseDate: "2016-04-23",
        imgURL:
            "https://aimm.edu/hubfs/Blog%20Images/Top%2010%20Album%20Covers%20of%202017/Tyler%20the%20Creator-%20Flower%20boy.jpg",
        tracks: [] // Add songs specific to this album
        ),
    Album(
        title: "Scorpion",
        aritst: Artist.defaultArtist(),
        genre: genres[2],
        releaseDate: "2018-06-29",
        imgURL:
            "https://images.theconversation.com/files/512871/original/file-20230301-26-ryosag.jpg?ixlib=rb-4.1.0&rect=97%2C79%2C5799%2C5817&q=45&auto=format&w=926&fit=clip",
        tracks: [] // Add songs specific to this album
        ),
    Album(
        title: "Divide",
        aritst: Artist.defaultArtist(),
        genre: genres[0],
        releaseDate: "2017-03-03",
        imgURL:
            "https://www.billboard.com/wp-content/uploads/2023/07/SZA-SOS-album-art-billboard-1240.jpg?w=800",
        tracks: [] // Add songs specific to this album
        ),
    Album(
        title: "1989",
        aritst: Artist.defaultArtist(),
        genre: genres[0],
        releaseDate: "2014-10-27",
        imgURL:
            "https://images.prismic.io/milanote/df7eeb83a07162b45ac2e882cac055de9411054a_cover.jpg?auto=compress,format",
        tracks: [] // Add songs specific to this album
        ),
    Album(
        title: "Thank U, Next",
        aritst: Artist.defaultArtist(),
        genre: genres[0],
        releaseDate: "2019-02-08",
        imgURL:
            "https://aimm.edu/hubfs/Blog%20Images/Top%2010%20Album%20Covers%20of%202017/Tyler%20the%20Creator-%20Flower%20boy.jpg",
        tracks: [] // Add songs specific to this album
        ),
    Album(
        title: "Purpose",
        aritst: Artist.defaultArtist(),
        genre: genres[0],
        releaseDate: "2015-11-13",
        imgURL:
            "https://aimm.edu/hubfs/Blog%20Images/Top%2010%20Album%20Covers%20of%202017/Tyler%20the%20Creator-%20Flower%20boy.jpg",
        tracks: [] // Add songs specific to this album
        ),
  ];
}
