const rnd = (n) => {
  const x = Math.sin(n * 91.7 + 13.1) * 43758.5453
  return x - Math.floor(x)
}
const q = (v, step) => Math.round(v / step) * step

/* ---------- shared gradients and patterns ---------- */
export function SceneDefs() {
  return (
    <svg width="0" height="0" style={{ position: 'absolute' }} aria-hidden="true">
      <defs>
        <linearGradient id="gGround" x1="0" x2="1" y1="0" y2="0">
          <stop offset="0" stopColor="#6e9f38" />
          <stop offset=".2" stopColor="#79a840" />
          <stop offset=".48" stopColor="#86ad4f" />
          <stop offset=".62" stopColor="#a1a98a" />
          <stop offset=".72" stopColor="#bdbdb4" />
          <stop offset="1" stopColor="#b3b3ac" />
        </linearGradient>
        <linearGradient id="gRoad" x1="0" x2="0" y1="0" y2="1">
          <stop offset="0" stopColor="#4c5057" />
          <stop offset="1" stopColor="#2b2e34" />
        </linearGradient>
        <linearGradient id="gBarn" x1="0" x2="0" y1="0" y2="1">
          <stop offset="0" stopColor="#b9392f" />
          <stop offset="1" stopColor="#8a2820" />
        </linearGradient>
        <linearGradient id="gSilo" x1="0" x2="1" y1="0" y2="0">
          <stop offset="0" stopColor="#a9b3ba" />
          <stop offset=".35" stopColor="#f1f4f6" />
          <stop offset="1" stopColor="#86919a" />
        </linearGradient>
        <linearGradient id="gGlass" x1="0" x2="0" y1="0" y2="1">
          <stop offset="0" stopColor="#a8cfe0" />
          <stop offset="1" stopColor="#5d8ba3" />
        </linearGradient>
        <linearGradient id="gWood" x1="0" x2="0" y1="0" y2="1">
          <stop offset="0" stopColor="#c99455" />
          <stop offset="1" stopColor="#8f5f2c" />
        </linearGradient>
        <linearGradient id="gHaze" x1="0" x2="0" y1="0" y2="1">
          <stop offset="0" stopColor="#eaf3dc" stopOpacity="0" />
          <stop offset="1" stopColor="#eaf3dc" stopOpacity=".9" />
        </linearGradient>
        <radialGradient id="gLeaf" cx=".35" cy=".3" r=".8">
          <stop offset="0" stopColor="#a6d663" />
          <stop offset="1" stopColor="#3c7a2b" />
        </radialGradient>
        <radialGradient id="gLeaf2" cx=".35" cy=".3" r=".8">
          <stop offset="0" stopColor="#86bf4f" />
          <stop offset="1" stopColor="#2f6624" />
        </radialGradient>

        <pattern id="pWinD" width="16" height="20" patternUnits="userSpaceOnUse">
          <rect x="3" y="4" width="10" height="12" rx="1" fill="#33505f" opacity=".7" />
        </pattern>
        <pattern id="pWinL" width="16" height="20" patternUnits="userSpaceOnUse">
          <rect x="3" y="4" width="10" height="12" rx="1" fill="#e3f4fb" opacity=".85" />
        </pattern>
        <pattern id="pAwnR" width="20" height="10" patternUnits="userSpaceOnUse">
          <rect width="10" height="10" fill="#c93a2e" />
          <rect x="10" width="10" height="10" fill="#f6efdc" />
        </pattern>
        <pattern id="pAwnG" width="20" height="10" patternUnits="userSpaceOnUse">
          <rect width="10" height="10" fill="#5f9e1c" />
          <rect x="10" width="10" height="10" fill="#f6efdc" />
        </pattern>
        <pattern id="pRows" width="14" height="10" patternUnits="userSpaceOnUse">
          <rect width="14" height="10" fill="#79ad45" />
          <rect y="6" width="14" height="4" fill="#5f9534" />
        </pattern>
        <pattern id="pRowsGold" width="14" height="10" patternUnits="userSpaceOnUse">
          <rect width="14" height="10" fill="#d7b653" />
          <rect y="6" width="14" height="4" fill="#c19a35" />
        </pattern>
      </defs>
    </svg>
  )
}

/* ---------- small building blocks ---------- */
function Tree({ x, y = 470, s = 1, dark }) {
  const g = dark ? 'url(#gLeaf2)' : 'url(#gLeaf)'
  return (
    <g transform={`translate(${x} ${y}) scale(${s})`}>
      <ellipse cx="0" cy="2" rx="34" ry="5" fill="#000" opacity=".15" />
      <rect x="-5" y="-60" width="10" height="62" fill="#6b4a2f" />
      <circle cx="-22" cy="-70" r="30" fill={g} />
      <circle cx="22" cy="-72" r="30" fill={g} />
      <circle cx="0" cy="-98" r="34" fill={g} />
      <circle cx="0" cy="-64" r="28" fill={g} />
    </g>
  )
}

function House({ x, y, w = 64, wall, roof }) {
  const h = w * 0.55
  return (
    <g transform={`translate(${x} ${y})`}>
      <rect x="0" y={-h} width={w} height={h} fill={wall} />
      <polygon points={`-5,${-h} ${w / 2},${-h - w * 0.38} ${w + 5},${-h}`} fill={roof} />
      <rect x={w * 0.14} y={-h * 0.62} width={w * 0.2} height={h * 0.3} fill="#6f93a8" />
      <rect x={w * 0.64} y={-h * 0.62} width={w * 0.2} height={h * 0.3} fill="#6f93a8" />
      <rect x={w * 0.42} y={-h * 0.55} width={w * 0.16} height={h * 0.55} fill="#6b4a2f" />
    </g>
  )
}

function Cow({ x, y, flip }) {
  return (
    <g transform={`translate(${x} ${y}) ${flip ? 'scale(-1 1)' : ''}`}>
      <path d="M-10 -8 V0 M-4 -6 V0 M6 -6 V0 M12 -8 V0" stroke="#d8d3c8" strokeWidth="3" strokeLinecap="round" />
      <ellipse cx="0" cy="-14" rx="16" ry="9" fill="#f4f1ea" />
      <ellipse cx="-5" cy="-16" rx="6" ry="4" fill="#2b2b2b" />
      <ellipse cx="7" cy="-12" rx="4" ry="3" fill="#2b2b2b" />
      <ellipse cx="18" cy="-18" rx="6" ry="5" fill="#f4f1ea" />
      <ellipse cx="22" cy="-16" rx="3" ry="2.5" fill="#e8b8a8" />
      <path d="M16 -23 L14 -27 M20 -23 L22 -27" stroke="#d8d3c8" strokeWidth="2" strokeLinecap="round" />
    </g>
  )
}

function Crate({ x, y, kind }) {
  const fill = kind === 't' ? '#d6392b' : kind === 'c' ? '#ef7d22' : '#7fb83a'
  return (
    <g transform={`translate(${x} ${y})`}>
      {[6, 15, 24].map((cx, i) => (
        <circle key={i} cx={cx} cy={i === 1 ? -3 : 0} r="7" fill={fill} />
      ))}
      <rect x="0" y="0" width="30" height="20" rx="2" fill="url(#gWood)" stroke="#5a3a17" strokeWidth="1.2" />
      <path d="M0 10 H30" stroke="#5a3a17" strokeWidth="1" opacity=".6" />
    </g>
  )
}

function Lamp({ x }) {
  return (
    <g>
      <rect x={x - 3} y="352" width="6" height="118" fill="#3c4650" />
      <path d={`M${x} 354 Q${x + 22} 346 ${x + 34} 358`} fill="none" stroke="#3c4650" strokeWidth="5" strokeLinecap="round" />
      <rect x={x + 26} y="356" width="18" height="7" rx="3" fill="#2d363e" />
      <rect x={x + 29} y="363" width="12" height="3" fill="#fff4c4" />
      <ellipse cx={x + 35} cy="369" rx="12" ry="5" fill="#fff4c4" opacity=".25" />
    </g>
  )
}

function Person({ x, shirt = '#3d7ea6', pants = '#3c4a63', hair = '#2b2118', skin = '#d9a77f' }) {
  return (
    <g transform={`translate(${x} 476)`}>
      <ellipse cx="0" cy="2" rx="14" ry="3" fill="#000" opacity=".18" />
      <rect x="-7" y="-34" width="6" height="34" rx="2" fill={pants} />
      <rect x="1" y="-34" width="6" height="34" rx="2" fill={pants} />
      <rect x="-10" y="-68" width="20" height="36" rx="6" fill={shirt} />
      <circle cx="0" cy="-78" r="8.5" fill={skin} />
      <path d="M-8.5 -80 Q0 -92 8.5 -80 Q0 -84 -8.5 -80Z" fill={hair} />
    </g>
  )
}

function Farmer({ x }) {
  return (
    <g transform={`translate(${x} 474)`}>
      <ellipse cx="0" cy="2" rx="16" ry="3" fill="#000" opacity=".2" />
      <rect x="-8" y="-36" width="7" height="36" rx="2" fill="#38486a" />
      <rect x="1" y="-36" width="7" height="36" rx="2" fill="#38486a" />
      <rect x="-9" y="-3" width="9" height="4" rx="2" fill="#3b2a1d" />
      <rect x="0" y="-3" width="9" height="4" rx="2" fill="#3b2a1d" />
      <rect x="-11" y="-72" width="22" height="38" rx="7" fill="#c24d36" />
      <path d="M-11 -58 H11 M-11 -46 H11 M-4 -72 V-34 M4 -72 V-34" stroke="#8f3322" strokeWidth="1.4" opacity=".7" />
      <rect x="-16" y="-70" width="6" height="28" rx="3" fill="#c24d36" />
      <g transform="translate(11 -68)">
        <g className="sp-wave">
          <rect x="-3" y="-28" width="6" height="28" rx="3" fill="#c24d36" />
          <circle cx="0" cy="-31" r="4.5" fill="#d9a77f" />
        </g>
      </g>
      <circle cx="0" cy="-82" r="9" fill="#d9a77f" />
      <ellipse cx="0" cy="-88" rx="17" ry="4" fill="#e2c070" />
      <path d="M-9 -88 Q0 -106 9 -88 Z" fill="#e2c070" />
      <path d="M-9 -89 H9" stroke="#a8482e" strokeWidth="2.5" />
    </g>
  )
}

function Barn({ x }) {
  return (
    <g transform={`translate(${x} 470)`}>
      <ellipse cx="125" cy="4" rx="150" ry="8" fill="#000" opacity=".18" />
      <path d="M0 0 H250 V-108 L214 -156 Q125 -204 36 -156 L0 -108 Z" fill="url(#gBarn)" />
      {Array.from({ length: 24 }, (_, i) => (
        <line key={i} x1={10 + i * 10} x2={10 + i * 10} y1="-100" y2="0" stroke="#6e1f19" strokeWidth="1" opacity=".35" />
      ))}
      <path d="M0 -108 L36 -156 Q125 -204 214 -156 L250 -108" fill="none" stroke="#f3ece0" strokeWidth="6" strokeLinejoin="round" />
      <rect x="78" y="-88" width="94" height="88" fill="#a22d25" stroke="#f3ece0" strokeWidth="5" />
      <path d="M78 -88 L172 0 M172 -88 L78 0" stroke="#f3ece0" strokeWidth="5" />
      <rect x="104" y="-146" width="42" height="36" fill="#5f1913" stroke="#f3ece0" strokeWidth="4" />
      <path d="M104 -146 L146 -110 M146 -146 L104 -110" stroke="#f3ece0" strokeWidth="3" />
      <circle cx="40" cy="-60" r="9" fill="#f3ece0" />
      <circle cx="40" cy="-60" r="5.5" fill="#35444f" />
      <circle cx="210" cy="-60" r="9" fill="#f3ece0" />
      <circle cx="210" cy="-60" r="5.5" fill="#35444f" />
      <rect x="208" y="-156" width="42" height="156" fill="#000" opacity=".08" />
    </g>
  )
}

function Silo({ x }) {
  return (
    <g transform={`translate(${x} 470)`}>
      <rect x="0" y="-150" width="44" height="150" fill="url(#gSilo)" />
      <path d="M-2 -148 Q22 -192 46 -148 Z" fill="#7b858c" />
      {[-110, -70, -30].map((y) => (
        <line key={y} x1="0" x2="44" y1={y} y2={y} stroke="#86919a" strokeWidth="2" />
      ))}
      <rect x="30" y="-150" width="14" height="150" fill="#000" opacity=".1" />
    </g>
  )
}

function Building({ x, w, h, fill, win }) {
  const top = 480 - h
  return (
    <g>
      <rect x={x} y={top} width={w} height={h} fill={fill} />
      <rect x={x} y={top} width={w} height={h - 60} fill={`url(#pWin${win})`} />
      <rect x={x + w - 12} y={top} width="12" height={h} fill="#000" opacity=".1" />
      <rect x={x - 3} y={top - 7} width={w + 6} height="9" fill={fill} />
      <rect x={x - 3} y={top - 7} width={w + 6} height="9" fill="#000" opacity=".22" />
      <rect x={x + w * 0.2} y={top - 17} width="26" height="10" fill="#8a9298" />
      <rect x={x} y="420" width={w} height="60" fill="#2f363c" />
      <rect x={x + 8} y="440" width={w - 16} height="40" fill="url(#gGlass)" />
      <rect x={x + 4} y="418" width={w - 8} height="20" fill={`url(#pAwn${x % 32 === 0 ? 'R' : 'G'})`} />
    </g>
  )
}

function Store({ x }) {
  const w = 272
  const top = 280
  return (
    <g>
      <rect x={x} y={top} width={w} height="200" fill="#efe5cc" />
      <rect x={x} y={top} width="10" height="200" fill="#000" opacity=".06" />
      <rect x={x - 4} y={top - 8} width={w + 8} height="10" fill="#bfae86" />
      <rect x={x + 18} y={top + 22} width={w - 36} height="64" rx="8" fill="#78be21" stroke="#4f8a12" strokeWidth="3" />
      <circle cx={x + 52} cy={top + 54} r="18" fill="#fff" />
      <path d={`M${x + 44} ${top + 62} C${x + 42} ${top + 52} ${x + 48} ${top + 45} ${x + 60} ${top + 46} C${x + 61} ${top + 56} ${x + 55} ${top + 62} ${x + 44} ${top + 62}Z`} fill="#78be21" />
      <text x={x + 80} y={top + 62} className="sp-svgtext" fontSize="34" fill="#fff">farm2bay</text>
      <text x={x + 82} y={top + 78} className="sp-svgtext" fontSize="11" letterSpacing="2.5" fill="#fff">FRESH MARKET</text>
      <rect x={x + 26} y={top + 100} width="70" height="34" fill="url(#gGlass)" stroke="#bfae86" strokeWidth="3" />
      <rect x={x + 176} y={top + 100} width="70" height="34" fill="url(#gGlass)" stroke="#bfae86" strokeWidth="3" />
      <rect x={x + 6} y="418" width={w - 12} height="22" fill="url(#pAwnG)" />
      <rect x={x + 14} y="440" width={w - 28} height="40" fill="url(#gGlass)" />
      <rect x={x + w / 2 - 20} y="444" width="40" height="36" fill="#2e3b33" stroke="#efe5cc" strokeWidth="3" />
      <Crate x={x + 22} y="456" kind="t" />
      <Crate x={x + 56} y="456" kind="c" />
      <Crate x={x + 198} y="456" kind="g" />
    </g>
  )
}

/* ---------- LAYERS ---------- */
export function CloudLayer() {
  const clouds = [[180, 120, 1], [700, 70, 0.8], [1150, 180, 0.7], [1650, 110, 1.1], [2200, 160, 0.9], [2750, 90, 1], [3200, 150, 0.8]]
  return (
    <svg className="sp-layer sp-layer--cloud" viewBox="0 0 4800 600" aria-hidden="true">
      {clouds.map(([x, y, s], i) => (
        <g key={i} transform={`translate(${x} ${y}) scale(${s})`} fill="#fff" opacity=".92">
          <ellipse cx="0" cy="12" rx="90" ry="18" />
          <ellipse cx="-30" cy="0" rx="42" ry="26" />
          <ellipse cx="22" cy="-8" rx="52" ry="32" />
          <ellipse cx="60" cy="6" rx="34" ry="20" />
        </g>
      ))}
    </svg>
  )
}

export function FarLayer() {
  return (
    <svg className="sp-layer sp-layer--far" viewBox="0 0 4800 600" aria-hidden="true">
      <path d="M0 440 V330 Q120 250 260 322 Q390 236 550 312 Q700 252 860 322 Q1010 272 1200 332 V440Z" fill="#b6cfd0" />
      <path d="M260 440 V352 Q520 292 770 352 Q970 304 1320 366 V440Z" fill="#a5c6b4" />
      {Array.from({ length: 64 }, (_, i) => {
        const x = 1260 + i * 46
        const h = 30 + rnd(i + 3) * (70 + Math.min(i, 36) * 4)
        const w = 30 + rnd(i + 9) * 22
        return <rect key={i} x={x} y={440 - h} width={w} height={h} fill={i % 3 ? '#b4c5d3' : '#a7bac9'} />
      })}
      <rect y="380" width="4800" height="90" fill="url(#gHaze)" />
      <rect y="440" width="4800" height="40" fill="#a9c78c" />
    </svg>
  )
}

export function MidLayer() {
  const palette = ['#cdbfa8', '#b98a73', '#8da2b3', '#e1d6bd', '#9fb4a6', '#c9a38a', '#a9b6c2']
  const mids = []
  let cx = 2640
  for (let i = 0; i < 26; i++) {
    const w = [80, 112, 96, 64, 128, 96, 112][i % 7]
    mids.push({ x: cx, w, h: q(110 + rnd(i + 20) * 190, 20), c: palette[i % palette.length], i })
    cx += w + (i % 4 === 3 ? 16 : 0)
  }
  const houses = [
    [2000, '#e7d7b6', '#a8483a'], [2090, '#c9d6dc', '#5a6470'], [2200, '#efe0c4', '#7b3f33'],
    [2330, '#d6c4a6', '#4e5a66'], [2450, '#e2c8b0', '#8a3b30'], [2560, '#cfd9c8', '#6b4a3a'],
  ]
  return (
    <svg className="sp-layer sp-layer--mid" viewBox="0 0 4800 600" aria-hidden="true">
      <path d="M0 470 V380 Q210 340 430 376 T850 368 T1280 378 T1720 362 T2160 380 T2620 372 T3000 388 V470Z" fill="#9cc671" />
      <path d="M0 470 V412 Q260 384 520 410 T1040 404 T1560 414 T2080 402 T2600 412 T3000 416 V470Z" fill="#86b25a" />

      <path d="M470 440 L560 400 H1420 L1540 440Z" fill="url(#pRows)" />
      <path d="M1640 440 L1730 398 H2420 L2540 440Z" fill="url(#pRowsGold)" />

      {Array.from({ length: 44 }, (_, i) => {
        const x = 20 + i * 62 + rnd(i) * 24
        if (x > 2750) return null
        const r = 13 + rnd(i + 5) * 11
        return <circle key={i} cx={x} cy={404 - rnd(i + 2) * 8} r={r} fill={['#3f6e31', '#4d7e3a', '#5a8c42'][i % 3]} />
      })}

      {/* windmill */}
      <g transform="translate(860 328)">
        <path d="M-16 114 L-3 0 M16 114 L3 0" stroke="#5d6a74" strokeWidth="3.5" fill="none" />
        <path d="M-13 84 H13 M-10 56 H10 M-7 28 H7 M-13 84 L10 56 M13 84 L-10 56 M-10 56 L7 28 M10 56 L-7 28" stroke="#5d6a74" strokeWidth="1.8" fill="none" />
        <path d="M0 0 L58 -4 L58 8 Z" fill="#7d8b95" />
        <g className="sp-fan">
          {Array.from({ length: 14 }, (_, i) => (
            <path key={i} d="M-3 -6 L-6 -34 L6 -34 L3 -6Z" fill="#cfd6db" stroke="#7d8b95" strokeWidth="1" transform={`rotate(${i * (360 / 14)})`} />
          ))}
          <circle r="34" fill="none" stroke="#7d8b95" strokeWidth="2" />
        </g>
        <circle r="5" fill="#4b5760" />
      </g>

      {/* cows */}
      <Cow x={1000} y={438} />
      <Cow x={1075} y={440} flip />
      <Cow x={1160} y={438} />

      {/* suburb houses */}
      {houses.map(([x, wall, roof]) => (
        <House key={x} x={x} y={442} w={64} wall={wall} roof={roof} />
      ))}

      {/* mid-distance city */}
      {mids.map(({ x, w, h, c, i }) => (
        <g key={i}>
          <rect x={x} y={440 - h} width={w} height={h} fill={c} />
          <rect x={x} y={440 - h} width={w} height={h} fill={`url(#pWin${i % 3 === 1 ? 'L' : 'D'})`} />
          <rect x={x + w - 10} y={440 - h} width="10" height={h} fill="#000" opacity=".1" />
          {i % 2 === 0 && <rect x={x + 10} y={440 - h - 10} width="22" height="10" fill="#8a9298" />}
        </g>
      ))}
    </svg>
  )
}

export function NearLayer() {
  const poleXs = [1190, 1520, 1850, 2180, 2510]
  const city = [
    [3152, 160, 260, '#cdbba2', 'D'], [3312, 128, 340, '#a56f5c', 'L'], [3440, 176, 420, '#7f99ac', 'L'],
    [3616, 144, 300, '#d9cdb4', 'D'], [3760, 176, 360, '#b58d78', 'L'],
    [4208, 144, 380, '#8aa0b0', 'L'], [4352, 160, 300, '#d4c3a8', 'D'], [4512, 128, 420, '#9a7a68', 'L'],
    [4640, 160, 340, '#c7b9a3', 'D'],
  ]
  return (
    <svg className="sp-layer sp-layer--near" viewBox="0 0 4800 600" aria-hidden="true">
      {/* ground band */}
      <rect x="0" y="440" width="4800" height="46" fill="url(#gGround)" />
      <rect x="0" y="440" width="4800" height="6" fill="#fff" opacity=".12" />

      {/* ===== FARM ===== */}
      <Barn x={30} />
      <Silo x={300} />
      <Farmer x={236} />
      <g>
        <rect x="390" y="446" width="700" height="5" fill="url(#gWood)" />
        <rect x="390" y="458" width="700" height="5" fill="url(#gWood)" />
        {Array.from({ length: 16 }, (_, i) => (
          <rect key={i} x={394 + i * 46} y="436" width="7" height="36" rx="2" fill="url(#gWood)" stroke="#5a3a17" strokeWidth=".8" />
        ))}
      </g>
      {[720, 772].map((x) => (
        <g key={x} transform={`translate(${x} 450)`}>
          <circle r="20" fill="#d8b24f" stroke="#a8812a" strokeWidth="1.5" />
          <circle r="14" fill="none" stroke="#b78d2f" strokeWidth="1.5" />
          <circle r="8" fill="none" stroke="#b78d2f" strokeWidth="1.5" />
          <circle r="3" fill="#b78d2f" />
        </g>
      ))}
      <Tree x={930} s={1.2} />
      <Tree x={1040} s={0.9} dark />

      {/* ===== COUNTRY ROAD ===== */}
      {poleXs.slice(0, -1).map((p, i) => {
        const n = poleXs[i + 1]
        const m = (p + n) / 2
        return (
          <path key={p} d={`M${p - 24} 342 Q${m - 24} 380 ${n - 24} 342 M${p + 24} 342 Q${m + 24} 380 ${n + 24} 342`} stroke="#2a2f33" strokeWidth="1.5" fill="none" />
        )
      })}
      {poleXs.map((p) => (
        <g key={p}>
          <rect x={p - 3.5} y="334" width="7" height="136" fill="#6b4f35" />
          <rect x={p - 30} y="340" width="60" height="5" fill="#5b432d" />
          <circle cx={p - 24} cy="339" r="3" fill="#cfd8dc" />
          <circle cx={p + 24} cy="339" r="3" fill="#cfd8dc" />
        </g>
      ))}
      <Tree x={1350} />
      <Tree x={1640} s={0.85} dark />
      <Tree x={1800} s={1.1} />
      <Tree x={2120} s={0.9} dark />
      <g transform="translate(1980 470)">
  <rect x="-46" y="-52" width="6" height="52" fill="#aab2b8" />
  <rect x="40" y="-52" width="6" height="52" fill="#aab2b8" />
  <rect x="-80" y="-124" width="160" height="76" rx="5" fill="#1d7a4b" stroke="#fff" strokeWidth="3" />
  <g fill="#fff">
    <rect x="-62" y="-92" width="14" height="32" />
    <rect x="-44" y="-108" width="18" height="48" />
    <rect x="-22" y="-84" width="14" height="24" />
  </g>
  <g fill="#1d7a4b">
    <rect x="-40" y="-100" width="4" height="6" />
    <rect x="-32" y="-100" width="4" height="6" />
    <rect x="-40" y="-88" width="4" height="6" />
    <rect x="-32" y="-88" width="4" height="6" />
  </g>
  <path d="M10 -86 H56 M44 -97 L58 -86 L44 -75" stroke="#fff" strokeWidth="5" fill="none" strokeLinecap="round" strokeLinejoin="round" />
</g>

      {/* ===== OUTSKIRTS ===== */}
      <g transform="translate(2600 470)">
        <rect x="-6" y="-96" width="6" height="96" fill="url(#gWood)" />
        <rect x="130" y="-96" width="6" height="96" fill="url(#gWood)" />
        <rect x="-12" y="-100" width="156" height="24" fill="url(#pAwnR)" />
        <rect x="-12" y="-78" width="156" height="4" fill="#000" opacity=".15" />
        <rect x="0" y="-34" width="130" height="34" fill="url(#gWood)" stroke="#5a3a17" strokeWidth="1.5" />
        <Crate x={8} y={-54} kind="t" />
        <Crate x={50} y={-54} kind="c" />
        <Crate x={92} y={-54} kind="g" />
      </g>
      <House x={2740} y={470} w={110} wall="#efe2c6" roof="#a8483a" />
      <Tree x={2880} s={0.9} />
      <g transform="translate(3000 470)">
  <rect x="-80" y="-120" width="8" height="120" fill="#6b7178" />
  <rect x="72" y="-120" width="8" height="120" fill="#6b7178" />
  <rect x="-100" y="-210" width="200" height="92" rx="4" fill="#f7f1dc" stroke="#5b6168" strokeWidth="4" />
  <rect x="-100" y="-210" width="200" height="92" rx="4" fill="#78be21" opacity=".2" />
  <path d="M-34 -140 C-46 -178 -12 -200 34 -196 C38 -158 6 -134 -34 -140 Z" fill="#78be21" />
  <path d="M-32 -142 L26 -190" stroke="#f7f1dc" strokeWidth="3" />
</g>
      {[2680, 2940, 3200].map((x) => <Lamp key={x} x={x} />)}

      {/* ===== CITY ===== */}
      {city.map(([x, w, h, fill, win]) => (
        <Building key={x} x={x} w={w} h={h} fill={fill} win={win} />
      ))}
      <Store x={3936} />
      {[3290, 3925, 4215, 4500].map((x) => <Lamp key={x} x={x} />)}
      <Person x={3330} shirt="#c24d36" />
      <Person x={4232} shirt="#3d7ea6" pants="#4a4a52" hair="#5a3a1f" />
      <Person x={4470} shirt="#78be21" pants="#2f3a48" skin="#b9855f" />
      <g transform="translate(4072 236)">
  <g className="sp-pin">
    <path d="M0 0 C-22 -26 -30 -40 -30 -56 A30 30 0 1 1 30 -56 C30 -40 22 -26 0 0 Z" fill="#f26b21" stroke="#fff" strokeWidth="4" />
    <circle cy="-56" r="11" fill="#fff" />
  </g>
</g>
      {/* ===== ROAD ===== */}
      <rect y="478" width="4800" height="107" fill="url(#gRoad)" />
      <rect y="585" width="4800" height="15" fill="url(#gGround)" />
      <rect y="474" width="4800" height="4" fill="#8d8f84" opacity=".55" />
      <rect y="484" width="4800" height="3" fill="#ece7cf" opacity=".8" />
      <rect y="578" width="4800" height="3" fill="#ece7cf" opacity=".8" />
      <line x1="0" x2="4800" y1="532" y2="532" stroke="#f1e9b5" strokeWidth="5" strokeDasharray="60 44" />
      {Array.from({ length: 8 }, (_, i) => (
        <rect key={i} x="3260" y={490 + i * 11} width="70" height="6" fill="#f4f1e6" opacity=".8" />
      ))}
    </svg>
  )
}

export function ForeLayer() {
  return (
    <svg className="sp-layer sp-layer--fore" viewBox="0 0 6400 600" aria-hidden="true">
      {Array.from({ length: 44 }, (_, i) => {
        const x = 40 + i * 96 + rnd(i + 40) * 50
        if (x > 4300) return null
        const h = 24 + rnd(i + 7) * 26
        return (
          <path
            key={i}
            d={`M${x} 604 Q${x - 6} ${604 - h * 0.6} ${x - 12} ${604 - h} M${x + 6} 604 Q${x + 8} ${604 - h * 0.7} ${x + 16} ${604 - h * 1.1} M${x + 12} 604 Q${x + 16} ${604 - h * 0.5} ${x + 26} ${604 - h * 0.8}`}
            stroke={i % 2 ? '#4a7f2c' : '#5f9a35'}
            strokeWidth="5"
            strokeLinecap="round"
            fill="none"
          />
        )
      })}
      {[1600, 3100, 4700].map((x) => (
        <rect key={x} x={x} y="-10" width="20" height="620" fill="#1f2a22" opacity=".8" style={{ filter: 'blur(4px)' }} />
      ))}
    </svg>
  )
}