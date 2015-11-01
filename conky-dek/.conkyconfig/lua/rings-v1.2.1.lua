--[[
Ring Meters by londonali1010 (2009)

This script draws percentage meters as rings. It is fully customisable; all options are described in the script.

IMPORTANT: if you are using the 'cpu' function, it will cause a segmentation fault if it tries to draw a ring
  straight away. The if statement near the end of the script uses a delay to make sure that this doesn't happen.
  It calculates the length of the delay by the number of updates since Conky started. Generally, a value of 5s
  is long enough, so if you update Conky every 1s, use update_num > 5 in that if statement (the default).
  If you only update Conky every 2s, you should change it to update_num > 3; conversely if you update Conky
  every 0.5s, you should use update_num > 10. ALSO, if you change your Conky, is it best to use
  "killall conky; conky" to update it, otherwise the update_num will not be reset and you will get an error.

To call this script in Conky, use the following (assuming that you save this script to ~/scripts/rings.lua):
        lua_load ~/scripts/rings-v1.2.1.lua
        lua_draw_hook_pre conky_main

Changelog:
+ v1.2.2 -- Added 4 more rings to CPU circle, 1 to Storage and changed the Battery circle to report GPU temp.
            This is a forked version by jh at brainiac dot com (17.01.2014)
+ v1.2.1 -- Fixed minor bug that caused script to crash if conky_parse() returns a nil value (20.10.2009)
+ v1.2 -- Added option for the ending angle of the rings (07.10.2009)
+ v1.1 -- Added options for the starting angle of the rings, and added the "max" variable, to allow for
            variables that output a numerical value rather than a percentage (29.09.2009)
+ v1.0 -- Original release (28.09.2009)

]]

normal="0x40bdd0"
warn="0xff7200"
crit="0xff000d"

corner_r=35
bg_colour=0x333333
bg_alpha=0.2


settings_table = {
    -- ONE based array
    {   -- [1]
        name='hwmon',
        arg='3 temp 2',
        max=110,
        bg_colour=0xdddddd,
        bg_alpha=0.8,
        fg_colour=normal,
        fg_alpha=0.8,
        x=200, y=120,
        radius=97,
        thickness=4,
        start_angle=0,
        end_angle=240
    },
    {   -- [2]
        name='cpu',
        arg='cpu0',
        max=100,
        bg_colour=0xdddddd,
        bg_alpha=0.8,
        fg_colour=normal,
        fg_alpha=0.8,
        x=200, y=120,
        radius=89,
        thickness=9,
        start_angle=0,
        end_angle=240
    },
    {   -- [3]
        name='cpu',
        arg='cpu1',
        max=100,
        bg_colour=0xdddddd,
        bg_alpha=0.7,
        fg_colour=normal,
        fg_alpha=0.8,
        x=200, y=120,
        radius=80,
        thickness=9,
        start_angle=0,
        end_angle=240
    },
    {   -- [4]
        name='cpu',
        arg='cpu2',
        max=100,
        bg_colour=0xdddddd,
        bg_alpha=0.6,
        fg_colour=normal,
        fg_alpha=0.8,
        x=200, y=120,
        radius=72,
        thickness=8,
        start_angle=0,
        end_angle=240
    },
    {   -- [5]
        name='cpu',
        arg='cpu3',
        max=100,
        bg_colour=0xdddddd,
        bg_alpha=0.5,
        fg_colour=normal,
        fg_alpha=0.8,
        x=200, y=120,
        radius=65,
        thickness=7,
        start_angle=0,
        end_angle=240
    },
    {   -- [6]
        name='cpu',
        arg='cpu4',
        max=100,
        bg_colour=0xdddddd,
        bg_alpha=0.8,
        fg_colour=normal,
        fg_alpha=0.8,
        x=200, y=120,
        radius=58,
        thickness=7,
        start_angle=0,
        end_angle=240
    },
    {   -- [7]
        name='cpu',
        arg='cpu5',
        max=100,
        bg_colour=0xdddddd,
        bg_alpha=0.7,
        fg_colour=normal,
        fg_alpha=0.8,
        x=200, y=120,
        radius=51,
        thickness=7,
        start_angle=0,
        end_angle=240
    },
    {   -- [8]
        name='cpu',
        arg='cpu6',
        max=100,
        bg_colour=0xdddddd,
        bg_alpha=0.6,
        fg_colour=normal,
        fg_alpha=0.8,
        x=200, y=120,
        radius=44,
        thickness=7,
        start_angle=0,
        end_angle=240
    },
    {   -- [9]
        name='cpu',
        arg='cpu7',
        max=100,
        bg_colour=0xdddddd,
        bg_alpha=0.5,
        fg_colour=normal,
        fg_alpha=0.8,
        x=200, y=120,
        radius=37,
        thickness=7,
        start_angle=0,
        end_angle=240
    },
    {   -- [10]
        name='memperc',
        arg='',
        max=100,
        bg_colour=0xdddddd,
        bg_alpha=0.8,
        fg_colour=normal,
        fg_alpha=0.8,
        x=340, y=234,
        radius=60,
        thickness=15,
        start_angle=180,
        end_angle=420
    },
    {   -- [11]
        name='swapperc',
        arg='',
        max=100,
        bg_colour=0xdddddd,
        bg_alpha=0.4,
        fg_colour=normal,
        fg_alpha=0.8,
        x=340, y=234,
        radius=45,
        thickness=10,
        start_angle=180,
        end_angle=420
    },
    {   -- [12]
        name='fs_used_perc',
        arg='/',
        max=100,
        bg_colour=0xdddddd,
        bg_alpha=0.8,
        fg_colour=normal,
        fg_alpha=0.8,
        x=220, y=280,
        radius=46,
        thickness=8,
        start_angle=0,
        end_angle=240
    },
    {   -- [13]
        name='fs_used_perc',
        arg='/home',
        max=100,
        bg_colour=0xdddddd,
        bg_alpha=0.6,
        fg_colour=normal,
        fg_alpha=0.8,
        x=220, y=280,
        radius=36,
        thickness=8,
        start_angle=0,
        end_angle=240
    },
    {   -- [14]
        name='fs_used_perc',
        arg='/tape',
        max=100,
        bg_colour=0xdddddd,
        bg_alpha=0.4,
        fg_colour=normal,
        fg_alpha=0.8,
        x=220, y=280,
        radius=26,
        thickness=8,
        start_angle=0,
        end_angle=240
    },
    {   -- [15]
        name='fs_used_perc',
        arg='/tapebak',
        max=100,
        bg_colour=0xdddddd,
        bg_alpha=0.4,
        fg_colour=normal,
        fg_alpha=0.8,
        x=220, y=280,
        radius=16,
        thickness=8,
        start_angle=0,
        end_angle=240
    },
    {   -- [16]
        name='downspeedf',
        arg='',
        max=2000,
        bg_colour=0xdddddd,
        bg_alpha=0.8,
        fg_colour=normal,
        fg_alpha=0.8,
        x=290, y=346,
        radius=30,
        thickness=12,
        start_angle=180,
        end_angle=420
    },
    {   -- [17]
        name='upspeedf',
        arg='',
        max=200,
        bg_colour=0xdddddd,
        bg_alpha=0.6,
        fg_colour=normal,
        fg_alpha=0.8,
        x=290, y=346,
        radius=18,
        thickness=8,
        start_angle=180,
        end_angle=420
    },
    {   -- [18]
        name='time',
        arg='%S',
        max=60,
        bg_colour=0xdddddd,
        bg_alpha=0.8,
        fg_colour=normal,
        fg_alpha=0.8,
        x=230, y=400,
        radius=30,
        thickness=4,
        -- use start of 0 and end of 360 for full circle
        start_angle=0,
        end_angle=360

    },
    {   -- [19]
        name='time',
        arg='%M',
        max=60,
        bg_colour=0xdddddd,
        bg_alpha=0.6,
        fg_colour=normal,
        fg_alpha=0.8,
        x=230, y=400,
        radius=23,
        thickness=8,
        start_angle=0,
        end_angle=360
    },
    {   -- [20]
        name='time',
        -- %H for 24 hr clock, %I for 12 hr, change max to match
        arg='%I',
        max=12,
        bg_colour=0xdddddd,
        bg_alpha=0.4,
        fg_colour=normal,
        fg_alpha=0.8,
        x=230, y=400,
        radius=12,
        thickness=10,
        start_angle=0,
        end_angle=360
    },
    {   -- [21] GPU temp
        name='hwmon',
        arg='2 temp 1',
        max=110,
        bg_colour=0xdddddd,
        bg_alpha=0.8,
        fg_colour=normal,
        fg_alpha=0.8,
        x=274, y=454,
        radius=18,
        thickness=10,
        start_angle=180,
        end_angle=420
    },
    {   -- [22]
        name='',
        arg='',
        max=100,
        bg_colour=0xdddddd,
        bg_alpha=0.6,
        fg_colour=normal,
        fg_alpha=0.6,
        x=274, y=454,
        radius=3,
        thickness=13,
        start_angle=0,
        end_angle=360
    },
}

require 'cairo'

function rgb_to_r_g_b(colour,alpha)
        return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)

        local w,h=conky_window.width,conky_window.height

        local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
        local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

        local angle_0=sa*(2*math.pi/360)-math.pi/2
        local angle_f=ea*(2*math.pi/360)-math.pi/2
        local t_arc=t*(angle_f-angle_0)

        -- Draw background ring

        cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
        cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
        cairo_set_line_width(cr,ring_w)
        cairo_stroke(cr)

        -- Draw indicator ring

        cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
        cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
        cairo_stroke(cr)
end

function conky_ring_stats()
        local function setup_rings(cr,pt)
                local str=''
                local value=0

                str=string.format('${%s %s}',pt['name'],pt['arg'])
                str=conky_parse(str)

                value=tonumber(str)
                if value == nil then value = 0 end
                pct=value/pt['max']

                draw_ring(cr,pct,pt)
        end

        if conky_window==nil then return end
        local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)

        local cr=cairo_create(cs)

        local updates=conky_parse('${updates}')
        update_num=tonumber(updates)

        if update_num>5 then
            for i in pairs(settings_table) do
                display_temp=cpu_temp_watch()
                setup_rings(cr,settings_table[i])
            end
        end
        cairo_surface_destroy(cs)
        cairo_destroy(cr)
end

function disk_watch()
    -- warn/crit levels in percent
    warn_disk=93
    crit_disk=98

    -- settings_table inexes for filesystems
    i_root=12
    i_home=13
    i_tape=14
    i_tapebak=15

    -- poser une boucle plus tard... pas simple

    disk=tonumber(conky_parse("${fs_used_perc /}"))

    if disk<warn_disk then
        settings_table[i_root]['fg_colour']=normal
    elseif disk<crit_disk then
        settings_table[i_root]['fg_colour']=warn
    else
        settings_table[i_root]['fg_colour']=crit
    end

    disk=tonumber(conky_parse("${fs_used_perc /home}"))

    if disk<warn_disk then
        settings_table[i_home]['fg_colour']=normal
    elseif disk<crit_disk then
        settings_table[i_home]['fg_colour']=warn
    else
        settings_table[i_home]['fg_colour']=crit
    end

    disk=tonumber(conky_parse("${fs_used_perc /tape}"))

    if disk<warn_disk then
        settings_table[i_tape]['fg_colour']=normal
    elseif disk<crit_disk then
        settings_table[i_tape]['fg_colour']=warn
    else
        settings_table[i_tape]['fg_colour']=crit
    end

    disk=tonumber(conky_parse("${fs_used_perc /tapebak}"))

    if disk<warn_disk then
        settings_table[i_tapebak]['fg_colour']=normal
    elseif disk<crit_disk then
        settings_table[i_tapebak]['fg_colour']=warn
    else
        settings_table[i_tapebak]['fg_colour']=crit
    end
end

function gpu_temp_watch()
    warn_value=65
    crit_value=80
    i_gtemp=21

    temperature=tonumber(conky_parse("${hwmon 2 temp 1}"))
    if temperature == nil then value = 0 end
    if temperature<warn_value then
        settings_table[i_gtemp]['fg_colour']=normal
    elseif temperature<crit_value then
        settings_table[i_gtemp]['fg_colour']=warn
    else
        settings_table[i_gtemp]['fg_colour']=crit
    end
end

function cpu_temp_watch()
    warn_value=50
    crit_value=70
    i_ctmp=1

    temperature=tonumber(conky_parse("${hwmon 3 temp 1}"))
    if temperature == nil then value = 0 end
    if temperature<warn_value then
        settings_table[i_ctmp]['fg_colour']=normal
    elseif temperature<crit_value then
        settings_table[i_ctmp]['fg_colour']=warn
    else
        settings_table[i_ctmp]['fg_colour']=crit
    end
end

function iface_watch()

    i_ifdown=16
    i_ifup=17

    iface=conky_parse("${if_existing /proc/net/route eth0}eth0${else}wlan0${endif}")
    settings_table[i_ifdown]['arg']=iface
    settings_table[i_ifup]['arg']=iface
end

function conky_draw_bg()
    if conky_window==nil then return end
    local w=conky_window.width
    local h=conky_window.height
    local cs=cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, w, h)
    cr=cairo_create(cs)

    cairo_move_to(cr,corner_r,0)
    cairo_line_to(cr,w-corner_r,0)
    cairo_curve_to(cr,w,0,w,0,w,corner_r)
    cairo_line_to(cr,w,h-corner_r)
    cairo_curve_to(cr,w,h,w,h,w-corner_r,h)
    cairo_line_to(cr,corner_r,h)
    cairo_curve_to(cr,0,h,0,h,0,h-corner_r)
    cairo_line_to(cr,0,corner_r)
    cairo_curve_to(cr,0,0,0,0,corner_r,0)
    cairo_close_path(cr)

    cairo_set_source_rgba(cr,rgb_to_r_g_b(bg_colour,bg_alpha))
    cairo_fill(cr)
end


function conky_main()
    cpu_temp_watch()
    gpu_temp_watch()
    disk_watch()
    iface_watch()
    conky_ring_stats()
end
