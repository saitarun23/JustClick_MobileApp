export default function Truck() {
  return (
    <svg className="sp-truck" viewBox="0 0 1200 600" aria-hidden="true">
      <defs>
        <linearGradient id="tRed" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#d9493b" />
          <stop offset=".5" stopColor="#b52f23" />
          <stop offset="1" stopColor="#7d1d16" />
        </linearGradient>
        <linearGradient id="tCream" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#fbf3dc" />
          <stop offset="1" stopColor="#d9c79b" />
        </linearGradient>
        <linearGradient id="tWood" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#d9a15a" />
          <stop offset="1" stopColor="#a06a2c" />
        </linearGradient>
        <linearGradient id="tChrome" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#ffffff" />
          <stop offset=".35" stopColor="#cfd6dc" />
          <stop offset=".62" stopColor="#8d979f" />
          <stop offset="1" stopColor="#e8edf0" />
        </linearGradient>
        <linearGradient id="tGlass" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#d4ecf8" />
          <stop offset="1" stopColor="#7fb2cf" />
        </linearGradient>
        <linearGradient id="tCan" x1="0" y1="0" x2="1" y2="0">
          <stop offset="0" stopColor="#87929a" />
          <stop offset=".3" stopColor="#f4f7f9" />
          <stop offset=".62" stopColor="#b9c2c8" />
          <stop offset="1" stopColor="#78828a" />
        </linearGradient>
        <linearGradient id="tSack" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#dcc18e" />
          <stop offset="1" stopColor="#b48f5a" />
        </linearGradient>
        <radialGradient id="tHub" cx=".4" cy=".35" r=".75">
          <stop offset="0" stopColor="#ffffff" />
          <stop offset=".6" stopColor="#c9d0d6" />
          <stop offset="1" stopColor="#7c868e" />
        </radialGradient>
        <radialGradient id="tTomato" cx=".35" cy=".3" r=".8">
          <stop offset="0" stopColor="#ff7f6e" />
          <stop offset="1" stopColor="#c42a1e" />
        </radialGradient>
        <radialGradient id="tBeam" cx=".1" cy=".5" r=".9">
          <stop offset="0" stopColor="#fff4c8" stopOpacity=".85" />
          <stop offset="1" stopColor="#fff4c8" stopOpacity="0" />
        </radialGradient>
      </defs>

      <g transform="translate(335 340)">
        {/* ground shadow */}
        <ellipse cx="222" cy="168" rx="248" ry="9" fill="#000" opacity=".3" />

        {/* exhaust puffs */}
        <rect x="-10" y="141" width="14" height="5" rx="2" fill="#3a3a3a" />
        {[0, 0.37, 0.74].map((d) => (
          <circle key={d} className="sp-puff" cx="-14" cy="143" r="6" fill="#e9e9e9" style={{ animationDelay: `${d}s` }} />
        ))}

        {/* dust behind the rear wheel */}
        {[0, 0.23, 0.46].map((d) => (
          <ellipse key={d} className="sp-dust" cx="74" cy="161" rx="14" ry="6" fill="#d8c7a0" style={{ animationDelay: `${1 + d}s` }} />
        ))}

        <g className="sp-truck__body">
          {/* chassis */}
          <rect x="0" y="130" width="440" height="9" fill="#17110f" />

          {/* bed back rails */}
          <rect x="2" y="34" width="203" height="9" rx="2" fill="url(#tWood)" stroke="#5a3a17" strokeWidth="1.5" />
          <rect x="2" y="52" width="203" height="9" rx="2" fill="url(#tWood)" stroke="#5a3a17" strokeWidth="1.5" />

          {/* cargo: tomatoes */}
          {[[22, 48], [38, 45], [54, 48], [30, 38], [46, 37]].map(([cx, cy], i) => (
            <g key={i}>
              <circle cx={cx} cy={cy} r="9" fill="url(#tTomato)" />
              <circle cx={cx} cy={cy - 8} r="2.5" fill="#4f8a2a" />
            </g>
          ))}
          <rect x="10" y="52" width="56" height="26" rx="2" fill="url(#tWood)" stroke="#5a3a17" strokeWidth="1.5" />
          <path d="M10 62 H66 M10 70 H66" stroke="#5a3a17" strokeWidth="1" opacity=".6" />

          {/* cargo: carrots */}
          {[0, 1, 2, 3, 4, 5, 6].map((i) => {
            const x = 76 + i * 8
            return (
              <g key={i}>
                <path d={`M${x} 46 q-6 -14 -2 -24 M${x} 46 q0 -16 3 -26 M${x} 46 q6 -12 8 -20`} stroke="#3f9a2c" strokeWidth="2.2" fill="none" strokeLinecap="round" />
                <rect x={x - 3.5} y="44" width="7" height="14" rx="3" fill="#ee7a1f" />
              </g>
            )
          })}
          <rect x="70" y="52" width="56" height="26" rx="2" fill="url(#tWood)" stroke="#5a3a17" strokeWidth="1.5" />
          <path d="M70 62 H126 M70 70 H126" stroke="#5a3a17" strokeWidth="1" opacity=".6" />

          {/* cargo: milk cans */}
          {[132, 155].map((x) => (
            <g key={x}>
              <rect x={x + 4} y="38" width="14" height="9" rx="2" fill="url(#tCan)" stroke="#5c666d" strokeWidth="1" />
              <ellipse cx={x + 11} cy="37" rx="9" ry="3.5" fill="#dfe5e9" stroke="#5c666d" strokeWidth="1" />
              <rect x={x} y="46" width="22" height="32" rx="5" fill="url(#tCan)" stroke="#5c666d" strokeWidth="1" />
              <rect x={x + 2} y="57" width="18" height="7" fill="#1c6fb2" opacity=".85" />
            </g>
          ))}

          {/* cargo: sack of powder */}
          <path d="M180 78 Q175 58 182 49 Q185 44 191 46 Q197 44 201 49 Q207 60 204 78 Z" fill="url(#tSack)" stroke="#7b5e34" strokeWidth="1.2" />
          <path d="M184 50 Q192 55 200 50" stroke="#7b5e34" strokeWidth="1.5" fill="none" />

          {/* stake posts */}
          <rect x="-2" y="26" width="7" height="54" rx="2" fill="url(#tWood)" stroke="#5a3a17" strokeWidth="1.5" />
          <rect x="199" y="26" width="7" height="54" rx="2" fill="url(#tWood)" stroke="#5a3a17" strokeWidth="1.5" />

          {/* bed side panel */}
          <path d="M0 78 H205 V130 H0 Z" fill="url(#tRed)" />
          <rect x="0" y="78" width="205" height="5" fill="#e4685a" opacity=".55" />
          <path d="M0 78 H205" stroke="#6e150f" strokeWidth="2" />
          <path d="M12 98 H62 M158 98 H196" stroke="#8c2018" strokeWidth="2" opacity=".6" />
          <rect x="1" y="86" width="5" height="12" rx="2" fill="#ff3b2f" />
          <path d="M70 130 A40 40 0 0 1 150 130 Z" fill="#120d0b" />
          <path d="M66 130 A44 44 0 0 1 154 130" fill="none" stroke="#f1e6c6" strokeWidth="3" />
          <rect x="-12" y="116" width="14" height="10" rx="3" fill="url(#tChrome)" stroke="#59636a" strokeWidth="1" />

          {/* hood */}
          <path d="M330 76 Q378 66 420 74 Q440 78 443 94 V130 H330 Z" fill="url(#tRed)" />
          <path d="M336 74 Q380 67 418 73" stroke="#ff9d8e" strokeWidth="2.5" opacity=".7" fill="none" />
          <path d="M352 102 H412 M352 110 H412" stroke="#7a1a12" strokeWidth="2" opacity=".55" />

          {/* cab lower */}
          <path d="M205 78 H334 V130 H205 Z" fill="url(#tRed)" />

          {/* cab upper (cream roof) */}
          <path d="M207 78 L211 36 Q213 22 232 22 H292 Q305 22 312 33 L336 78 Z" fill="url(#tCream)" stroke="#8e7a4c" strokeWidth="1.5" />
          <path d="M222 74 L225 38 Q226 31 234 31 H289 Q297 31 302 38 L322 74 Z" fill="url(#tGlass)" stroke="#3a3a3a" strokeWidth="2" />
          <polygon points="240,32 262,32 238,73 226,73" fill="#fff" opacity=".28" />
          <path d="M270 31 V74" stroke="#cdbd92" strokeWidth="4" />

          {/* door + badge */}
          <rect x="216" y="80" width="80" height="48" rx="6" fill="none" stroke="#7a1a12" strokeWidth="1.5" />
          <rect x="280" y="92" width="12" height="4" rx="2" fill="url(#tChrome)" />
          <circle cx="256" cy="93" r="12" fill="#f6ecd0" stroke="#78be21" strokeWidth="3" />
          <path d="M250 99 C248 91 253 86 262 86 C263 94 258 99 250 99 Z" fill="#78be21" />
          <path d="M251 98 L259 90" stroke="#f6ecd0" strokeWidth="1" />
          <text x="256" y="122" textAnchor="middle" className="sp-svgtext" fontSize="15" fill="#f6ecd0">farm2bay</text>

          {/* front fender */}
          <path d="M298 130 C298 92 318 82 347 82 C376 82 396 92 398 130 Z" fill="url(#tRed)" stroke="#6e150f" strokeWidth="1.5" />
          <path d="M306 130 A41 41 0 0 1 388 130 Z" fill="#120d0b" />
          <path d="M302 130 A45 45 0 0 1 392 130" fill="none" stroke="#f1e6c6" strokeWidth="3" />

          {/* wheels */}
          {[110, 347].map((cx) => (
            <g key={cx} transform={`translate(${cx} 135)`}>
              <circle r="30" fill="#161616" />
              <circle r="28" fill="none" stroke="#2f2f2f" strokeWidth="2" />
              <circle r="22" fill="#f4eed8" />
              <circle r="22" fill="none" stroke="#d6cfb2" strokeWidth="1" />
              <g className="sp-wheel">
                <circle r="14.5" fill="url(#tHub)" stroke="#59636a" strokeWidth="1.2" />
                <circle r="5" fill="#b52f23" />
                {[0, 72, 144, 216, 288].map((a) => (
                  <circle key={a} cx="0" cy="-9.6" r="1.6" fill="#59636a" transform={`rotate(${a})`} />
                ))}
                <rect x="-1" y="-14" width="2" height="9" fill="#fff" opacity=".85" />
              </g>
            </g>
          ))}

          {/* grille, bumper, headlight, mirror */}
          <rect x="434" y="84" width="10" height="44" rx="4" fill="url(#tChrome)" stroke="#59636a" strokeWidth="1" />
          <path d="M436 92 H443 M436 99 H443 M436 106 H443 M436 113 H443 M436 120 H443" stroke="#59636a" strokeWidth="1.4" />
          <rect x="428" y="119" width="26" height="11" rx="4" fill="url(#tChrome)" stroke="#59636a" strokeWidth="1" />
          <circle cx="425" cy="92" r="9" fill="url(#tChrome)" stroke="#59636a" strokeWidth="1.2" />
          <circle cx="426" cy="92" r="6" fill="#fff8d6" />
          <path d="M318 58 L328 54" stroke="#59636a" strokeWidth="2.5" />
          <rect x="326" y="48" width="8" height="12" rx="2" fill="url(#tChrome)" stroke="#59636a" strokeWidth="1" />
          <ellipse className="sp-beam" cx="505" cy="96" rx="80" ry="22" fill="url(#tBeam)" />
        </g>
      </g>
    </svg>
  )
}