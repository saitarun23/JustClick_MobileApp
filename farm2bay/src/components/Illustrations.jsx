import React from 'react';

/* =========================================================
   1. BRAND LOGO MARK & VINTAGE FARM2BAY SPLASH TITLE
   ========================================================= */
export function Farm2BayLogoMark({ size = 42 }) {
  return (
    <svg
      width={size}
      height={size}
      viewBox="0 0 52 52"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      aria-hidden="true"
    >
      <rect
        x="3"
        y="3"
        width="46"
        height="46"
        rx="14"
        fill="#1b4332"
        stroke="#1c261a"
        strokeWidth="2.5"
      />
      <circle cx="26" cy="26" r="18" fill="#78be21" fillOpacity="0.16" />
      {/* Botanical Sprout */}
      <path
        d="M26 29C26 20 32 14 39 14C39 22 33 29 26 29Z"
        fill="#78be21"
        stroke="#ffffff"
        strokeWidth="2"
        strokeLinejoin="round"
      />
      <path
        d="M26 29C26 22 20 17 13 17C13 24 19 29 26 29Z"
        fill="#a3e635"
        stroke="#ffffff"
        strokeWidth="2"
        strokeLinejoin="round"
      />
      {/* Harvest Crate Base */}
      <rect
        x="14"
        y="31"
        width="24"
        height="9"
        rx="2.5"
        fill="#d99b52"
        stroke="#ffffff"
        strokeWidth="2"
      />
      <line x1="26" y1="27" x2="26" y2="31" stroke="#ffffff" strokeWidth="2" />
    </svg>
  );
}

export function SplashVintageTitle() {
  return (
    <div className="splash-brand-lockup">
      <Farm2BayLogoMark size={54} />
      <svg
        viewBox="0 0 540 104"
        className="vintage-title-svg"
        role="img"
        aria-label="FARM2BAY"
      >
        <defs>
          <filter id="vintage-grain" x="-4%" y="-4%" width="108%" height="108%">
            <feTurbulence
              type="fractalNoise"
              baseFrequency="0.7"
              numOctaves="2"
              result="noise"
            />
            <feDisplacementMap
              in="SourceGraphic"
              in2="noise"
              scale="1.2"
              xChannelSelector="R"
              yChannelSelector="G"
            />
          </filter>
        </defs>

        {/* Decorative Vintage Side Rules */}
        <line x1="36" y1="54" x2="78" y2="54" stroke="#78be21" strokeWidth="3.5" strokeLinecap="round" />
        <circle cx="28" cy="54" r="3.5" fill="#c84b31" />
        <line x1="462" y1="54" x2="504" y2="54" stroke="#78be21" strokeWidth="3.5" strokeLinecap="round" />
        <circle cx="512" cy="54" r="3.5" fill="#c84b31" />

        {/* Subtle Offset Drop Shadow for Editorial Depth */}
        <text
          x="272"
          y="74"
          textAnchor="middle"
          fontFamily="'Alfa Slab One', Georgia, serif"
          fontSize="58"
          letterSpacing="3"
          fill="#e7efe0"
        >
          FARM 2 BAY
        </text>

        {/* Main Vintage Two-Tone Title */}
        <g filter="url(#vintage-grain)">
          <text
            x="270"
            y="71"
            textAnchor="middle"
            fontFamily="'Alfa Slab One', Georgia, serif"
            fontSize="58"
            letterSpacing="3"
          >
            <tspan fill="#1b4332">FARM</tspan>
            <tspan fill="#c84b31"> 2 </tspan>
            <tspan fill="#78be21">BAY</tspan>
          </text>
        </g>
      </svg>
    </div>
  );
}

/* =========================================================
   2. CONTINUOUS CINEMATIC FARM-TO-CITY PANORAMA (2200px WIDE)
   ========================================================= */
export function PanoramicWorldIllustration() {
  return (
    <svg
      viewBox="0 0 2200 260"
      className="panorama-svg"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      aria-hidden="true"
    >
      {/* ---------------- SKYLINE HORIZON SILHOUETTES (FAR DEPTH) ---------------- */}
      <path
        d="M0 218C180 158 340 164 520 218H0Z"
        fill="#f2f8ea"
      />
      <path
        d="M420 218C610 166 790 172 980 218H420Z"
        fill="#eef6e4"
      />
      {/* Distant City Silhouette rising as truck nears city */}
      <g fill="#f3f7ef">
        <rect x="1360" y="138" width="46" height="80" rx="3" />
        <rect x="1414" y="112" width="54" height="106" rx="3" />
        <rect x="1478" y="146" width="42" height="72" rx="3" />
        <rect x="1780" y="124" width="52" height="94" rx="3" />
        <rect x="1842" y="102" width="60" height="116" rx="3" />
        <rect x="1912" y="136" width="48" height="82" rx="3" />
      </g>

      {/* ====================================================================
          ZONE 1 (x: 0 - 820): REALISTIC COUNTRYSIDE FARM & ORCHARD
         ==================================================================== */}
      {/* Warm Morning Sun */}
      <circle cx="110" cy="54" r="24" fill="#ffd166" />
      <circle cx="110" cy="54" r="32" fill="#ffd166" fillOpacity="0.22" />

      {/* Rolling Terraced Farm Fields */}
      <path
        d="M0 224C140 164 310 170 470 224H0Z"
        fill="#e3f3ce"
        stroke="#78be21"
        strokeWidth="2"
      />
      <path
        d="M360 224C520 176 690 180 860 224H360Z"
        fill="#d5ecba"
        stroke="#78be21"
        strokeWidth="2"
      />
      {/* Crop Furrow Lines */}
      <path d="M290 214C340 198 400 198 450 214" stroke="#78be21" strokeWidth="2" strokeDasharray="8 6" />
      <path d="M510 214C565 198 630 198 685 214" stroke="#78be21" strokeWidth="2" strokeDasharray="8 6" />

      {/* Grain Silo beside Barn */}
      <rect x="146" y="112" width="34" height="96" fill="#e9ecef" stroke="#1c261a" strokeWidth="2.2" />
      <path d="M146 112C146 95 180 95 180 112H146Z" fill="#adb5bd" stroke="#1c261a" strokeWidth="2.2" />
      <line x1="146" y1="136" x2="180" y2="136" stroke="#1c261a" strokeWidth="1.5" />
      <line x1="146" y1="162" x2="180" y2="162" stroke="#1c261a" strokeWidth="1.5" />
      <line x1="146" y1="188" x2="180" y2="188" stroke="#1c261a" strokeWidth="1.5" />

      {/* Classic Rustic Red Barn */}
      <rect x="180" y="132" width="96" height="76" fill="#c84b31" stroke="#1c261a" strokeWidth="2.4" />
      <path
        d="M170 134L228 92L286 134H170Z"
        fill="#9e351e"
        stroke="#1c261a"
        strokeWidth="2.4"
        strokeLinejoin="round"
      />
      {/* Hayloft Window */}
      <rect x="218" y="108" width="20" height="16" fill="#ffffff" stroke="#1c261a" strokeWidth="2" />
      {/* Barn Double Doors */}
      <rect x="206" y="160" width="44" height="48" fill="#ffffff" stroke="#1c261a" strokeWidth="2.2" />
      <line x1="228" y1="160" x2="228" y2="208" stroke="#1c261a" strokeWidth="2" />
      <line x1="206" y1="160" x2="228" y2="208" stroke="#c84b31" strokeWidth="1.8" />
      <line x1="250" y1="160" x2="228" y2="208" stroke="#c84b31" strokeWidth="1.8" />

      {/* Farm Windmill */}
      <path d="M326 208L338 124H348L360 208" stroke="#1c261a" strokeWidth="2.2" fill="#ffffff" />
      <line x1="331" y1="176" x2="355" y2="176" stroke="#1c261a" strokeWidth="2" />
      <line x1="334" y1="150" x2="352" y2="150" stroke="#1c261a" strokeWidth="2" />
      <g className="windmill-blades" style={{ transformOrigin: '343px 124px' }}>
        <line x1="343" y1="92" x2="343" y2="156" stroke="#1c261a" strokeWidth="2.4" />
        <line x1="311" y1="124" x2="375" y2="124" stroke="#1c261a" strokeWidth="2.4" />
        <rect x="339" y="94" width="8" height="18" fill="#78be21" stroke="#1c261a" strokeWidth="1.5" />
        <rect x="339" y="136" width="8" height="18" fill="#78be21" stroke="#1c261a" strokeWidth="1.5" />
        <rect x="313" y="120" width="18" height="8" fill="#78be21" stroke="#1c261a" strokeWidth="1.5" />
        <rect x="355" y="120" width="18" height="8" fill="#78be21" stroke="#1c261a" strokeWidth="1.5" />
      </g>
      <circle cx="343" cy="124" r="5" fill="#c84b31" stroke="#1c261a" strokeWidth="2" />

      {/* Wooden Post-and-Rail Farm Fence */}
      <g stroke="#8d5b2c" strokeWidth="2.5">
        <line x1="400" y1="196" x2="620" y2="196" />
        <line x1="400" y1="208" x2="620" y2="208" />
        <line x1="412" y1="186" x2="412" y2="222" strokeWidth="4" />
        <line x1="462" y1="186" x2="462" y2="222" strokeWidth="4" />
        <line x1="512" y1="186" x2="512" y2="222" strokeWidth="4" />
        <line x1="562" y1="186" x2="562" y2="222" strokeWidth="4" />
        <line x1="612" y1="186" x2="612" y2="222" strokeWidth="4" />
      </g>

      {/* Orchard Trees */}
      <g>
        <rect x="77" y="182" width="8" height="30" fill="#7f4f24" />
        <circle cx="81" cy="166" r="22" fill="#78be21" stroke="#1c261a" strokeWidth="2.2" />
        <circle cx="74" cy="160" r="3" fill="#c84b31" />
        <circle cx="88" cy="168" r="3" fill="#c84b31" />

        <rect x="656" y="182" width="8" height="32" fill="#7f4f24" />
        <circle cx="660" cy="164" r="24" fill="#5a9e18" stroke="#1c261a" strokeWidth="2.2" />
        <circle cx="694" cy="174" r="18" fill="#78be21" stroke="#1c261a" strokeWidth="2.2" />
      </g>

      {/* ====================================================================
          ZONE 2 (x: 820 - 1340): SCENIC COUNTRYSIDE TO CITY TRANSITION
         ==================================================================== */}
      {/* Roadside Trees & Highway Milestone */}
      <rect x="920" y="184" width="7" height="32" fill="#7f4f24" />
      <circle cx="923" cy="168" r="20" fill="#78be21" stroke="#1c261a" strokeWidth="2.2" />

      {/* Highway Direction Signboard (Visual Arrow Only) */}
      <rect x="1068" y="176" width="5" height="42" fill="#495057" />
      <rect x="1046" y="152" width="48" height="26" rx="5" fill="#78be21" stroke="#1c261a" strokeWidth="2.2" />
      <path d="M1058 165H1082M1075 158L1082 165L1075 172" stroke="#ffffff" strokeWidth="2.6" strokeLinecap="round" strokeLinejoin="round" />

      <rect x="1210" y="184" width="7" height="32" fill="#7f4f24" />
      <circle cx="1213" cy="168" r="20" fill="#5a9e18" stroke="#1c261a" strokeWidth="2.2" />

      {/* ====================================================================
          ZONE 3 (x: 1340 - 2200): ARCHITECTURAL CITY SKYLINE & ARRIVAL BAY
         ==================================================================== */}
      {/* City Streetlamps */}
      <g stroke="#1c261a" strokeWidth="2.2">
        <line x1="1380" y1="218" x2="1380" y2="152" />
        <path d="M1380 152C1380 144 1392 144 1392 150" fill="none" />
        <circle cx="1392" cy="152" r="4" fill="#ffd166" />

        <line x1="1760" y1="218" x2="1760" y2="152" />
        <path d="M1760 152C1760 144 1772 144 1772 150" fill="none" />
        <circle cx="1772" cy="152" r="4" fill="#ffd166" />
      </g>

      {/* Building 1: Editorial Cream & Sage Apartment */}
      <rect x="1420" y="96" width="84" height="122" rx="4" fill="#ffffff" stroke="#1c261a" strokeWidth="2.4" />
      <rect x="1420" y="96" width="84" height="14" fill="#78be21" stroke="#1c261a" strokeWidth="2.2" />
      <g fill="#eef7e1" stroke="#78be21" strokeWidth="1.8">
        <rect x="1434" y="122" width="16" height="18" rx="2" />
        <rect x="1472" y="122" width="16" height="18" rx="2" />
        <rect x="1434" y="150" width="16" height="18" rx="2" />
        <rect x="1472" y="150" width="16" height="18" rx="2" />
      </g>
      <rect x="1452" y="184" width="20" height="34" fill="#d99b52" stroke="#1c261a" strokeWidth="2" />

      {/* Building 2: Tall City Tower */}
      <rect x="1520" y="54" width="96" height="164" rx="4" fill="#ffffff" stroke="#1c261a" strokeWidth="2.4" />
      <rect x="1536" y="42" width="64" height="12" rx="2" fill="#1b4332" stroke="#1c261a" strokeWidth="2" />
      <g fill="#f3fae8" stroke="#78be21" strokeWidth="1.8">
        <rect x="1536" y="70" width="18" height="20" rx="2" />
        <rect x="1582" y="70" width="18" height="20" rx="2" />
        <rect x="1536" y="102" width="18" height="20" rx="2" />
        <rect x="1582" y="102" width="18" height="20" rx="2" />
        <rect x="1536" y="134" width="18" height="20" rx="2" />
        <rect x="1582" y="134" width="18" height="20" rx="2" />
      </g>
      {/* Terracotta Awning */}
      <path d="M1532 174H1604L1610 188H1526L1532 174Z" fill="#c84b31" stroke="#1c261a" strokeWidth="2" />
      <rect x="1554" y="188" width="28" height="30" fill="#eef7e1" stroke="#1c261a" strokeWidth="2" />

      {/* Building 3: Neighborhood Market Bay (Destination Stop!) */}
      <rect x="1636" y="114" width="106" height="104" rx="4" fill="#ffffff" stroke="#1c261a" strokeWidth="2.4" />
      {/* Striped Green & Cream Awning */}
      <path d="M1630 148H1748L1754 166H1624L1630 148Z" fill="#78be21" stroke="#1c261a" strokeWidth="2.2" />
      <line x1="1654" y1="148" x2="1652" y2="166" stroke="#ffffff" strokeWidth="4" />
      <line x1="1688" y1="148" x2="1688" y2="166" stroke="#ffffff" strokeWidth="4" />
      <line x1="1722" y1="148" x2="1724" y2="166" stroke="#ffffff" strokeWidth="4" />
      {/* Destination Location Pin above City Bay */}
      <path
        d="M1689 56C1677 56 1668 65 1668 77C1668 91 1689 108 1689 108C1689 108 1710 91 1710 77C1710 65 1701 56 1689 56Z"
        fill="#c84b31"
        stroke="#1c261a"
        strokeWidth="2.4"
      />
      <circle cx="1689" cy="76" r="7" fill="#ffffff" />

      {/* Right Edge City Buildings */}
      <rect x="1804" y="82" width="88" height="136" rx="4" fill="#ffffff" stroke="#1c261a" strokeWidth="2.4" />
      <g fill="#eef7e1" stroke="#78be21" strokeWidth="1.8">
        <rect x="1820" y="102" width="18" height="22" rx="2" />
        <rect x="1858" y="102" width="18" height="22" rx="2" />
        <rect x="1820" y="138" width="18" height="22" rx="2" />
        <rect x="1858" y="138" width="18" height="22" rx="2" />
      </g>
      <rect x="1910" y="118" width="96" height="100" rx="4" fill="#ffffff" stroke="#1c261a" strokeWidth="2.4" />
    </svg>
  );
}

/* =========================================================
   3. VINTAGE TWO-TONE PICKUP TRUCK (FIXED CENTER + SPINNING WHEELS)
   ========================================================= */
export function FarmTruckIllustration({ className = '' }) {
  return (
    <svg
      viewBox="0 0 390 196"
      className={className}
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      aria-label="Farm2Bay Delivery Pickup Truck"
    >
      <defs>
        <linearGradient id="truckBodyGrad" x1="0" y1="60" x2="0" y2="150" gradientUnits="userSpaceOnUse">
          <stop offset="0%" stopColor="#4c855e" />
          <stop offset="55%" stopColor="#356344" />
          <stop offset="100%" stopColor="#244730" />
        </linearGradient>
        <linearGradient id="headlightBeam" x1="342" y1="114" x2="390" y2="122" gradientUnits="userSpaceOnUse">
          <stop offset="0%" stopColor="#ffd166" stopOpacity="0.55" />
          <stop offset="100%" stopColor="#ffd166" stopOpacity="0" />
        </linearGradient>
      </defs>

      {/* Subtle Headlight Glow Cone */}
      <polygon points="340,106 390,94 390,136 340,122" fill="url(#headlightBeam)" />

      {/* Exhaust Smoke Puffs */}
      <circle className="exhaust-puff puff-1" cx="28" cy="148" r="6" fill="#d8e2dc" />
      <circle className="exhaust-puff puff-2" cx="14" cy="140" r="9" fill="#e9ecef" />
      <circle className="exhaust-puff puff-3" cx="4" cy="131" r="11" fill="#f1f3f5" />

      {/* Ground Contact Shadow */}
      <ellipse cx="192" cy="178" rx="154" ry="8" fill="#1c261a" fillOpacity="0.18" />

      {/* Loaded Harvest Goods in Truck Bed */}
      <g className="truck-cargo">
        {/* Fresh Glass Milk Bottles */}
        <rect x="64" y="54" width="22" height="38" rx="4" fill="#ffffff" stroke="#1c261a" strokeWidth="2.4" />
        <rect x="68" y="47" width="14" height="8" rx="2" fill="#78be21" stroke="#1c261a" strokeWidth="2" />
        {/* Terracotta Pickle Jar */}
        <rect x="92" y="60" width="26" height="32" rx="6" fill="#c84b31" stroke="#1c261a" strokeWidth="2.4" />
        <rect x="95" y="54" width="20" height="7" rx="2" fill="#f4a261" stroke="#1c261a" strokeWidth="2" />
        {/* Leafy Farm Vegetables & Carrots */}
        <circle cx="134" cy="68" r="17" fill="#78be21" stroke="#1c261a" strokeWidth="2.4" />
        <circle cx="151" cy="73" r="14" fill="#558b15" stroke="#1c261a" strokeWidth="2.4" />
        <path d="M123 53C120 41 129 37 134 48" stroke="#2d6a4f" strokeWidth="2.5" strokeLinecap="round" />
        <path d="M144 58L152 43" stroke="#f77f00" strokeWidth="4" strokeLinecap="round" />
      </g>

      {/* Golden Oak Wooden Bed Slats */}
      <rect x="48" y="76" width="128" height="10" rx="2" fill="#e0a458" stroke="#1c261a" strokeWidth="2.4" />
      <rect x="48" y="91" width="128" height="10" rx="2" fill="#c68136" stroke="#1c261a" strokeWidth="2.4" />
      <rect x="58" y="73" width="8" height="35" fill="#b36d25" stroke="#1c261a" strokeWidth="2" />
      <rect x="112" y="73" width="8" height="35" fill="#b36d25" stroke="#1c261a" strokeWidth="2" />
      <rect x="160" y="73" width="8" height="35" fill="#b36d25" stroke="#1c261a" strokeWidth="2" />

      {/* Exhaust Pipe */}
      <path d="M36 144H48V150H36C34 150 34 144 36 144Z" fill="#adb5bd" stroke="#1c261a" strokeWidth="2" />

      {/* Vintage Two-Tone Pickup Body (Deep Sage-Forest Green) */}
      <path
        d="M44 106H178V64C178 55 185 48 194 48H240C251 48 259 55 264 66L275 94H324C335 94 344 103 344 114V146H44V106Z"
        fill="url(#truckBodyGrad)"
        stroke="#1c261a"
        strokeWidth="3"
        strokeLinejoin="round"
      />

      {/* Classic Cream Two-Tone Cab Roof */}
      <path
        d="M180 63C180 55 186 49 194 49H240C250 49 258 55 263 65H180V63Z"
        fill="#faf6ee"
        stroke="#1c261a"
        strokeWidth="2.4"
      />

      {/* Cab Window + Driver Silhouette */}
      <path
        d="M190 65H242C248 65 253 69 256 75L263 92H190V65Z"
        fill="#eef7f2"
        stroke="#1c261a"
        strokeWidth="2.4"
        strokeLinejoin="round"
      />
      {/* Driver Head & Cap inside Cab */}
      <circle cx="234" cy="79" r="6.5" fill="#f2c6a0" stroke="#1c261a" strokeWidth="1.8" />
      <path d="M227 76C227 71 231 69 235 69C239 69 242 71 242 76H227Z" fill="#c84b31" />
      <line x1="241" y1="76" x2="246" y2="76" stroke="#c84b31" strokeWidth="2.2" strokeLinecap="round" />
      <line x1="222" y1="65" x2="222" y2="92" stroke="#1c261a" strokeWidth="2.2" />

      {/* Chrome Side Mirror */}
      <rect x="256" y="76" width="6" height="11" rx="2" fill="#e9ecef" stroke="#1c261a" strokeWidth="1.8" />

      {/* Cream Side Trim & Door Handle */}
      <path d="M52 122H336" stroke="#faf6ee" strokeWidth="3.5" />
      <path d="M52 122H336" stroke="#1c261a" strokeWidth="1.2" />
      <rect x="198" y="106" width="12" height="4" rx="2" fill="#e9ecef" stroke="#1c261a" strokeWidth="1.5" />

      {/* Fender Arches */}
      <path
        d="M70 146C70 128 84 116 100 116C116 116 130 128 130 146"
        fill="#1c261a"
        stroke="#faf6ee"
        strokeWidth="2.5"
      />
      <path
        d="M254 146C254 128 268 116 284 116C300 116 314 128 314 146"
        fill="#1c261a"
        stroke="#faf6ee"
        strokeWidth="2.5"
      />

      {/* Chrome Front & Rear Bumpers + Headlight */}
      <rect x="36" y="137" width="15" height="11" rx="5" fill="#e9ecef" stroke="#1c261a" strokeWidth="2.4" />
      <rect x="334" y="137" width="17" height="11" rx="5" fill="#e9ecef" stroke="#1c261a" strokeWidth="2.4" />
      <rect x="336" y="106" width="9" height="15" rx="4" fill="#ffd166" stroke="#1c261a" strokeWidth="2.2" />

      {/* Rear Spinning Whitewall Wheel */}
      <g className="wheel-spin" style={{ transformOrigin: '100px 148px' }}>
        <circle cx="100" cy="148" r="25" fill="#212529" stroke="#1c261a" strokeWidth="3" />
        {/* Tire Tread Notches */}
        <circle
          cx="100"
          cy="148"
          r="22"
          stroke="#495057"
          strokeWidth="2.5"
          strokeDasharray="5 5"
        />
        {/* Cream Whitewall */}
        <circle cx="100" cy="148" r="15.5" fill="#faf6ee" stroke="#1c261a" strokeWidth="2" />
        {/* Sage-Green Rim & Chrome Hubcap */}
        <circle cx="100" cy="148" r="9.5" fill="#3a6b4c" stroke="#1c261a" strokeWidth="2" />
        <circle cx="100" cy="148" r="4.5" fill="#e9ecef" stroke="#1c261a" strokeWidth="1.6" />
        <line x1="100" y1="133" x2="100" y2="163" stroke="#1c261a" strokeWidth="1.6" />
        <line x1="85" y1="148" x2="115" y2="148" stroke="#1c261a" strokeWidth="1.6" />
      </g>

      {/* Front Spinning Whitewall Wheel */}
      <g className="wheel-spin" style={{ transformOrigin: '284px 148px' }}>
        <circle cx="284" cy="148" r="25" fill="#212529" stroke="#1c261a" strokeWidth="3" />
        <circle
          cx="284"
          cy="148"
          r="22"
          stroke="#495057"
          strokeWidth="2.5"
          strokeDasharray="5 5"
        />
        <circle cx="284" cy="148" r="15.5" fill="#faf6ee" stroke="#1c261a" strokeWidth="2" />
        <circle cx="284" cy="148" r="9.5" fill="#3a6b4c" stroke="#1c261a" strokeWidth="2" />
        <circle cx="284" cy="148" r="4.5" fill="#e9ecef" stroke="#1c261a" strokeWidth="1.6" />
        <line x1="284" y1="133" x2="284" y2="163" stroke="#1c261a" strokeWidth="1.6" />
        <line x1="269" y1="148" x2="299" y2="148" stroke="#1c261a" strokeWidth="1.6" />
      </g>
    </svg>
  );
}

/* =========================================================
   4. HERO HANDS HOLDING WOODEN CRATE (IMAGES 1 & 2 STYLE)
   ========================================================= */
export function WoodenCrateHeroIllustration() {
  return (
    <svg
      viewBox="0 0 460 350"
      className="hero-crate-svg"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      aria-label="Hands holding wooden crate of fresh organic produce"
    >
      <g stroke="#78be21" strokeWidth="2" strokeOpacity="0.55" strokeLinecap="round">
        <path d="M74 64C64 48 84 36 94 52C104 68 84 80 74 64Z" />
        <path d="M84 44L88 34" />
        <circle cx="384" cy="60" r="18" />
        <path d="M384 42C380 34 390 32 392 40" />
        <path d="M402 138C416 128 428 144 412 156C396 168 388 148 402 138Z" />
        <path d="M52 150C38 140 50 122 66 132C82 142 66 160 52 150Z" />
      </g>

      <circle cx="176" cy="138" r="34" fill="#78be21" stroke="#1c261a" strokeWidth="2.8" />
      <circle cx="232" cy="124" r="38" fill="#558b15" stroke="#1c261a" strokeWidth="2.8" />
      <circle cx="286" cy="140" r="32" fill="#8ac926" stroke="#1c261a" strokeWidth="2.8" />

      <rect x="132" y="102" width="38" height="78" rx="8" fill="#ffffff" stroke="#1c261a" strokeWidth="2.8" />
      <rect x="139" y="88" width="24" height="15" rx="4" fill="#78be21" stroke="#1c261a" strokeWidth="2.5" />
      <rect x="138" y="128" width="26" height="24" rx="3" fill="#eef7e1" />

      <path
        d="M192 90L214 172L172 166L192 90Z"
        fill="#f77f00"
        stroke="#1c261a"
        strokeWidth="2.8"
        strokeLinejoin="round"
      />
      <path
        d="M192 90C186 72 176 70 182 86M192 90C194 70 204 70 198 86"
        stroke="#386641"
        strokeWidth="2.8"
        strokeLinecap="round"
      />

      <rect x="272" y="108" width="48" height="68" rx="12" fill="#c84b31" stroke="#1c261a" strokeWidth="2.8" />
      <rect x="278" y="96" width="36" height="13" rx="4" fill="#f4a261" stroke="#1c261a" strokeWidth="2.5" />
      <rect x="280" y="128" width="32" height="22" rx="4" fill="#ffffff" stroke="#1c261a" strokeWidth="1.8" />

      <circle cx="236" cy="162" r="24" fill="#e63946" stroke="#1c261a" strokeWidth="2.8" />
      <path d="M236 138L230 130M236 138L243 131" stroke="#386641" strokeWidth="2.8" strokeLinecap="round" />

      <rect x="112" y="170" width="236" height="24" rx="4" fill="#dda15e" stroke="#1c261a" strokeWidth="2.8" />
      <rect x="112" y="202" width="236" height="24" rx="4" fill="#bc6c25" stroke="#1c261a" strokeWidth="2.8" />
      <rect x="112" y="234" width="236" height="24" rx="4" fill="#dda15e" stroke="#1c261a" strokeWidth="2.8" />
      <rect x="126" y="166" width="16" height="96" rx="3" fill="#b07d4f" stroke="#1c261a" strokeWidth="2.5" />
      <rect x="318" y="166" width="16" height="96" rx="3" fill="#b07d4f" stroke="#1c261a" strokeWidth="2.5" />

      <path
        d="M12 244L98 252C116 254 134 242 154 242C166 242 172 252 160 260L124 270L164 272C174 273 174 285 162 286L116 288L16 302"
        fill="#f2c6a0"
        stroke="#1c261a"
        strokeWidth="2.8"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
      <path
        d="M448 244L362 252C344 254 326 242 306 242C294 242 288 252 300 260L336 270L296 272C286 273 286 285 298 286L344 288L444 302"
        fill="#f2c6a0"
        stroke="#1c261a"
        strokeWidth="2.8"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
}

/* =========================================================
   5. HOW IT WORKS & PRODUCT CARD ILLUSTRATIONS
   ========================================================= */
export function HarvestStepIllustration() {
  return (
    <svg viewBox="0 0 180 140" className="step-svg" fill="none" xmlns="http://www.w3.org/2000/svg">
      <circle cx="90" cy="70" r="56" fill="#f3fae8" />
      <circle cx="122" cy="36" r="12" fill="#ffd166" stroke="#1c261a" strokeWidth="2.2" />
      <path d="M40 104C65 86 115 86 140 104" stroke="#78be21" strokeWidth="4" strokeLinecap="round" />
      <path d="M76 44L88 96L64 94L76 44Z" fill="#f77f00" stroke="#1c261a" strokeWidth="2.4" strokeLinejoin="round" />
      <path d="M76 44C70 30 62 30 68 42M76 44C78 28 86 30 80 42" stroke="#386641" strokeWidth="2.4" strokeLinecap="round" />
      <circle cx="106" cy="74" r="20" fill="#78be21" stroke="#1c261a" strokeWidth="2.4" />
      <circle cx="106" cy="74" r="10" fill="#9ef01a" />
    </svg>
  );
}

export function PackingStepIllustration() {
  return (
    <svg viewBox="0 0 180 140" className="step-svg" fill="none" xmlns="http://www.w3.org/2000/svg">
      <circle cx="90" cy="70" r="56" fill="#f3fae8" />
      <rect x="52" y="42" width="24" height="48" rx="6" fill="#ffffff" stroke="#1c261a" strokeWidth="2.4" />
      <rect x="56" y="33" width="16" height="9" rx="3" fill="#78be21" stroke="#1c261a" strokeWidth="2" />
      <rect x="82" y="48" width="30" height="42" rx="8" fill="#c84b31" stroke="#1c261a" strokeWidth="2.4" />
      <rect x="86" y="40" width="22" height="8" rx="3" fill="#f4a261" stroke="#1c261a" strokeWidth="2" />
      <rect x="44" y="84" width="92" height="14" rx="3" fill="#dda15e" stroke="#1c261a" strokeWidth="2.4" />
      <rect x="44" y="102" width="92" height="14" rx="3" fill="#bc6c25" stroke="#1c261a" strokeWidth="2.4" />
    </svg>
  );
}

export function DeliveryPartnerIllustration() {
  return (
    <svg viewBox="0 0 180 140" className="step-svg" fill="none" xmlns="http://www.w3.org/2000/svg">
      <circle cx="90" cy="70" r="56" fill="#f3fae8" />
      <circle cx="90" cy="48" r="18" fill="#f7cbb0" stroke="#1c261a" strokeWidth="2.4" />
      <path d="M72 44C72 32 80 25 90 25C100 25 108 32 108 44H72Z" fill="#c84b31" stroke="#1c261a" strokeWidth="2.4" />
      <path d="M74 44H116C116 48 107 50 94 50" fill="#9e351e" stroke="#1c261a" strokeWidth="2" />
      <circle cx="84" cy="49" r="2" fill="#1c261a" />
      <circle cx="96" cy="49" r="2" fill="#1c261a" />
      <path d="M85 56C88 59 92 59 95 56" stroke="#1c261a" strokeWidth="2" strokeLinecap="round" />
      <circle cx="74" cy="78" r="10" fill="#78be21" stroke="#1c261a" strokeWidth="2.2" />
      <circle cx="91" cy="76" r="11" fill="#e63946" stroke="#1c261a" strokeWidth="2.2" />
      <circle cx="107" cy="79" r="9" fill="#f77f00" stroke="#1c261a" strokeWidth="2.2" />
      <rect x="56" y="84" width="68" height="11" rx="2.5" fill="#dda15e" stroke="#1c261a" strokeWidth="2.2" />
      <rect x="56" y="98" width="68" height="11" rx="2.5" fill="#bc6c25" stroke="#1c261a" strokeWidth="2.2" />
    </svg>
  );
}

export function ProductIllustration({ category, accent = '#78be21' }) {
  switch (category) {
    case 'dairy':
      return (
        <svg viewBox="0 0 140 120" className="product-svg" fill="none">
          <circle cx="70" cy="60" r="46" fill="#f3fae8" />
          <rect x="44" y="34" width="30" height="58" rx="7" fill="#ffffff" stroke="#1c261a" strokeWidth="2.5" />
          <rect x="49" y="24" width="20" height="11" rx="3" fill="#78be21" stroke="#1c261a" strokeWidth="2.2" />
          <rect x="49" y="54" width="20" height="18" rx="3" fill={accent} fillOpacity="0.28" />
          <rect x="78" y="56" width="28" height="36" rx="8" fill={accent} stroke="#1c261a" strokeWidth="2.5" />
          <rect x="81" y="49" width="22" height="8" rx="3" fill="#ffffff" stroke="#1c261a" strokeWidth="2.2" />
        </svg>
      );

    case 'vegetables':
      return (
        <svg viewBox="0 0 140 120" className="product-svg" fill="none">
          <circle cx="70" cy="60" r="46" fill="#f3fae8" />
          <circle cx="56" cy="56" r="22" fill="#78be21" stroke="#1c261a" strokeWidth="2.5" />
          <circle cx="84" cy="62" r="20" fill={accent} stroke="#1c261a" strokeWidth="2.5" />
          <path d="M66 32L76 88L54 86L66 32Z" fill="#f77f00" stroke="#1c261a" strokeWidth="2.5" strokeLinejoin="round" />
          <path d="M66 32C62 22 56 22 60 30M66 32C68 20 74 22 70 30" stroke="#386641" strokeWidth="2.5" strokeLinecap="round" />
        </svg>
      );

    case 'pickles':
      return (
        <svg viewBox="0 0 140 120" className="product-svg" fill="none">
          <circle cx="70" cy="60" r="46" fill="#fdf4ec" />
          <rect x="46" y="36" width="48" height="58" rx="12" fill={accent} stroke="#1c261a" strokeWidth="2.5" />
          <rect x="51" y="25" width="38" height="12" rx="4" fill="#78be21" stroke="#1c261a" strokeWidth="2.5" />
          <rect x="54" y="52" width="32" height="24" rx="4" fill="#ffffff" stroke="#1c261a" strokeWidth="2" />
          <line x1="60" y1="61" x2="80" y2="61" stroke="#1c261a" strokeWidth="2" strokeLinecap="round" />
          <line x1="63" y1="68" x2="77" y2="68" stroke="#78be21" strokeWidth="2" strokeLinecap="round" />
        </svg>
      );

    case 'powders':
      return (
        <svg viewBox="0 0 140 120" className="product-svg" fill="none">
          <circle cx="70" cy="60" r="46" fill="#faf5eb" />
          <path
            d="M46 28H94L98 90C98 93 95 96 92 96H48C45 96 42 93 42 90L46 28Z"
            fill="#e6ccb2"
            stroke="#1c261a"
            strokeWidth="2.5"
          />
          <line x1="45" y1="38" x2="95" y2="38" stroke="#1c261a" strokeWidth="2" />
          <circle cx="70" cy="66" r="16" fill={accent} stroke="#1c261a" strokeWidth="2.2" />
          <path d="M58 84C64 78 76 78 82 84" stroke="#78be21" strokeWidth="2.5" strokeLinecap="round" />
        </svg>
      );

    default:
      return (
        <svg viewBox="0 0 140 120" className="product-svg" fill="none">
          <circle cx="70" cy="60" r="46" fill="#f3fae8" />
          <rect x="44" y="42" width="32" height="50" rx="9" fill={accent} stroke="#1c261a" strokeWidth="2.5" />
          <rect x="49" y="33" width="22" height="10" rx="3" fill="#ffffff" stroke="#1c261a" strokeWidth="2.2" />
          <path d="M74 72C74 56 102 56 102 72V92H74V72Z" fill="#dda15e" stroke="#1c261a" strokeWidth="2.5" />
        </svg>
      );
  }
}

export function BasketIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.2" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
      <path d="M5 10h14l-1.5 9h-11L5 10z" />
      <path d="M9 10l3-5 3 5" />
    </svg>
  );
}

export function ReplayIcon() {
  return (
    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.3" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
      <path d="M3 12a9 9 0 1 0 3-6.7L3 8" />
      <path d="M3 3v5h5" />
    </svg>
  );
}

export function CheckBadgeIcon({ size = 32 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="#1c261a" strokeWidth="2.6" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
      <polyline points="20 6 9 17 4 12" />
    </svg>
  );
}