import React from 'react';

/* =========================================================
   1. BRAND EMBLEM & FARMER'S MARKET POSTER TITLE (FARM2BAY)
   ========================================================= */
export function Farm2BayLogoMark({ size = 44 }) {
  return (
    <svg
      width={size}
      height={size}
      viewBox="0 0 56 56"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      aria-hidden="true"
    >
      <defs>
        <linearGradient id="badgeLeafGrad" x1="10" y1="8" x2="46" y2="48" gradientUnits="userSpaceOnUse">
          <stop offset="0%" stopColor="#8bd42a" />
          <stop offset="100%" stopColor="#5a9614" />
        </linearGradient>
      </defs>
      <rect
        x="3"
        y="3"
        width="50"
        height="50"
        rx="15"
        fill="#ffffff"
        stroke="#1c261a"
        strokeWidth="2.8"
      />
      <circle cx="28" cy="28" r="20" fill="url(#badgeLeafGrad)" fillOpacity="0.16" />
      {/* Botanical Sprout */}
      <path
        d="M28 31C28 21 34 15 41 15C41 23 35 31 28 31Z"
        fill="#78be21"
        stroke="#1c261a"
        strokeWidth="2.2"
        strokeLinejoin="round"
      />
      <path
        d="M28 31C28 23 22 18 15 18C15 25 21 31 28 31Z"
        fill="#9ee03b"
        stroke="#1c261a"
        strokeWidth="2.2"
        strokeLinejoin="round"
      />
      {/* Wooden Harvest Crate */}
      <rect
        x="15"
        y="33"
        width="26"
        height="10"
        rx="2.5"
        fill="#d99b52"
        stroke="#1c261a"
        strokeWidth="2.2"
      />
      <line x1="28" y1="29" x2="28" y2="33" stroke="#1c261a" strokeWidth="2.2" />
    </svg>
  );
}

export function SplashVintageTitle() {
  return (
    <div className="splash-brand-lockup">
      <Farm2BayLogoMark size={54} />
      <svg
        viewBox="0 0 460 124"
        className="vintage-title-svg"
        role="img"
        aria-label="FARM2BAY"
      >
        <defs>
          {/* Distressed Ink Stamp Filter matching Farmer's Market Poster */}
          <filter id="farmers-stamp" x="-5%" y="-5%" width="110%" height="110%">
            <feTurbulence
              type="fractalNoise"
              baseFrequency="0.75"
              numOctaves="2"
              seed="4"
              result="noise"
            />
            <feDisplacementMap
              in="SourceGraphic"
              in2="noise"
              scale="1.8"
              xChannelSelector="R"
              yChannelSelector="G"
            />
          </filter>
        </defs>

        {/* Subtle Dynamic Poster Tilt (-2.5deg) matching Farmer's Market Reference */}
        <g transform="rotate(-2.5 230 62)">
          {/* Soft Print Shadow */}
          <text
            x="233"
            y="95"
            textAnchor="middle"
            fontFamily="'Oswald', Impact, sans-serif"
            fontWeight="700"
            fontSize="86"
            letterSpacing="3"
            fill="#e6ece1"
          >
            FARM2BAY
          </text>

          {/* Main Distressed Vintage Condensed Typography */}
          <g filter="url(#farmers-stamp)">
            <text
              x="230"
              y="92"
              textAnchor="middle"
              fontFamily="'Oswald', Impact, sans-serif"
              fontWeight="700"
              fontSize="86"
              letterSpacing="3"
            >
              <tspan fill="#b83a2d">FARM</tspan>
              <tspan fill="#78be21">2</tspan>
              <tspan fill="#1c261a">BAY</tspan>
            </text>
          </g>
        </g>
      </svg>
    </div>
  );
}

/* =========================================================
   2. REALISTIC FARM -> HIGHWAY -> CITY WATERFRONT BAY (2400px)
   ========================================================= */
export function PanoramicWorldIllustration() {
  return (
    <svg
      viewBox="0 0 2400 280"
      className="panorama-svg"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      aria-hidden="true"
    >
      <defs>
        {/* Realistic Sky & Sunlight Gradients */}
        <radialGradient id="morningSunGlow" cx="50%" cy="50%" r="50%">
          <stop offset="0%" stopColor="#ffd166" stopOpacity="0.55" />
          <stop offset="100%" stopColor="#ffd166" stopOpacity="0" />
        </radialGradient>
        <linearGradient id="farmHillBack" x1="0" y1="150" x2="0" y2="245" gradientUnits="userSpaceOnUse">
          <stop offset="0%" stopColor="#e8f5d6" />
          <stop offset="100%" stopColor="#d4ebb6" />
        </linearGradient>
        <linearGradient id="farmHillFront" x1="0" y1="170" x2="0" y2="245" gradientUnits="userSpaceOnUse">
          <stop offset="0%" stopColor="#8ed134" />
          <stop offset="100%" stopColor="#69ab19" />
        </linearGradient>
        <linearGradient id="barnWallGrad" x1="0" y1="130" x2="0" y2="228" gradientUnits="userSpaceOnUse">
          <stop offset="0%" stopColor="#c84637" />
          <stop offset="100%" stopColor="#9c2e22" />
        </linearGradient>
        <linearGradient id="siloMetalGrad" x1="210" y1="110" x2="256" y2="110" gradientUnits="userSpaceOnUse">
          <stop offset="0%" stopColor="#ced4da" />
          <stop offset="45%" stopColor="#f8f9fa" />
          <stop offset="100%" stopColor="#adb5bd" />
        </linearGradient>
        <linearGradient id="bayWaterGrad" x1="0" y1="204" x2="0" y2="248" gradientUnits="userSpaceOnUse">
          <stop offset="0%" stopColor="#4ea8de" />
          <stop offset="50%" stopColor="#2a9d8f" />
          <stop offset="100%" stopColor="#1d6f8a" />
        </linearGradient>
        <linearGradient id="glassTowerGrad" x1="0" y1="45" x2="1" y2="1">
          <stop offset="0%" stopColor="#e8f4f8" />
          <stop offset="50%" stopColor="#ffffff" />
          <stop offset="100%" stopColor="#dceef2" />
        </linearGradient>
      </defs>

      {/* ====================================================================
          PART 1 (x: 100 - 880): REALISTIC COUNTRYSIDE FARM (VISIBLE AT START!)
         ==================================================================== */}
      {/* Warm Sun & Glow */}
      <circle cx="195" cy="58" r="54" fill="url(#morningSunGlow)" />
      <circle cx="195" cy="58" r="22" fill="#ffd166" />

      {/* Rolling Multi-Layer Farm Hills */}
      <path
        d="M40 242C190 158 390 162 570 242H40Z"
        fill="url(#farmHillBack)"
      />
      <path
        d="M360 242C540 168 750 172 940 242H360Z"
        fill="url(#farmHillFront)"
        fillOpacity="0.26"
      />
      {/* Ploughed Crop Furrows */}
      <path d="M470 228C545 204 630 204 705 228" stroke="#78be21" strokeWidth="2.4" strokeDasharray="10 7" />
      <path d="M510 237C585 216 670 216 745 237" stroke="#5a9614" strokeWidth="2.2" strokeDasharray="8 6" />

      {/* Realistic Metallic Grain Silo */}
      <rect x="214" y="114" width="40" height="114" fill="url(#siloMetalGrad)" stroke="#1c261a" strokeWidth="2" />
      <path d="M214 114C214 93 254 93 254 114H214Z" fill="#adb5bd" stroke="#1c261a" strokeWidth="2" />
      <line x1="214" y1="142" x2="254" y2="142" stroke="#6c757d" strokeWidth="1.5" />
      <line x1="214" y1="170" x2="254" y2="170" stroke="#6c757d" strokeWidth="1.5" />
      <line x1="214" y1="198" x2="254" y2="198" stroke="#6c757d" strokeWidth="1.5" />

      {/* Classic Timber & Red Barn */}
      <rect x="254" y="138" width="116" height="90" fill="url(#barnWallGrad)" stroke="#1c261a" strokeWidth="2.4" />
      {/* Vertical Barn Wood Planks */}
      <line x1="278" y1="138" x2="278" y2="228" stroke="#7d2218" strokeWidth="1.4" />
      <line x1="346" y1="138" x2="346" y2="228" stroke="#7d2218" strokeWidth="1.4" />
      {/* Gambrel Barn Roof */}
      <path
        d="M244 140L272 104L312 86L352 104L380 140H244Z"
        fill="#7f1d1d"
        stroke="#1c261a"
        strokeWidth="2.4"
        strokeLinejoin="round"
      />
      {/* Hayloft Window */}
      <rect x="300" y="108" width="24" height="20" rx="2" fill="#fff8eb" stroke="#1c261a" strokeWidth="2" />
      {/* White-Trimmed Barn Doors */}
      <rect x="288" y="172" width="48" height="56" fill="#ffffff" stroke="#1c261a" strokeWidth="2.2" />
      <line x1="312" y1="172" x2="312" y2="228" stroke="#1c261a" strokeWidth="2" />
      <line x1="288" y1="172" x2="312" y2="228" stroke="#b83a2d" strokeWidth="2" />
      <line x1="336" y1="172" x2="312" y2="228" stroke="#b83a2d" strokeWidth="2" />

      {/* Farm Windmill with Spinning Rotor */}
      <path d="M412 228L426 128H436L450 228" stroke="#1c261a" strokeWidth="2.2" fill="#f8f9fa" />
      <line x1="417" y1="192" x2="445" y2="192" stroke="#1c261a" strokeWidth="2" />
      <line x1="421" y1="160" x2="441" y2="160" stroke="#1c261a" strokeWidth="2" />
      <g className="windmill-blades" style={{ transformOrigin: '431px 128px' }}>
        <line x1="431" y1="90" x2="431" y2="166" stroke="#1c261a" strokeWidth="2.4" />
        <line x1="393" y1="128" x2="469" y2="128" stroke="#1c261a" strokeWidth="2.4" />
        <polygon points="431,92 440,114 426,114" fill="#78be21" stroke="#1c261a" strokeWidth="1.5" />
        <polygon points="431,164 422,142 436,142" fill="#78be21" stroke="#1c261a" strokeWidth="1.5" />
        <polygon points="395,128 417,119 417,133" fill="#78be21" stroke="#1c261a" strokeWidth="1.5" />
        <polygon points="467,128 445,137 445,123" fill="#78be21" stroke="#1c261a" strokeWidth="1.5" />
      </g>
      <circle cx="431" cy="128" r="5.5" fill="#b83a2d" stroke="#1c261a" strokeWidth="2" />

      {/* Lush Orchard Trees & Wooden Fence */}
      <g>
        <rect x="156" y="194" width="9" height="36" fill="#6f4518" />
        <circle cx="160" cy="176" r="25" fill="#78be21" stroke="#1c261a" strokeWidth="2.2" />
        <circle cx="151" cy="168" r="3.5" fill="#b83a2d" />
        <circle cx="170" cy="178" r="3.5" fill="#b83a2d" />

        <rect x="748" y="196" width="9" height="36" fill="#6f4518" />
        <circle cx="752" cy="176" r="26" fill="#5e9c16" stroke="#1c261a" strokeWidth="2.2" />
        <circle cx="786" cy="186" r="20" fill="#78be21" stroke="#1c261a" strokeWidth="2.2" />
      </g>

      <g stroke="#8d5b2c" strokeWidth="2.6">
        <line x1="485" y1="212" x2="725" y2="212" />
        <line x1="485" y1="224" x2="725" y2="224" />
        <line x1="498" y1="202" x2="498" y2="238" strokeWidth="4" />
        <line x1="554" y1="202" x2="554" y2="238" strokeWidth="4" />
        <line x1="610" y1="202" x2="610" y2="238" strokeWidth="4" />
        <line x1="666" y1="202" x2="666" y2="238" strokeWidth="4" />
        <line x1="720" y1="202" x2="720" y2="238" strokeWidth="4" />
      </g>

      {/* ====================================================================
          PART 2 (x: 920 - 1440): SCENIC COUNTRY-TO-COAST HIGHWAY TRANSITION
         ==================================================================== */}
      <path d="M880 242C1020 184 1180 188 1340 242H880Z" fill="#eef6e4" />

      <rect x="980" y="196" width="8" height="36" fill="#6f4518" />
      <circle cx="984" cy="178" r="22" fill="#78be21" stroke="#1c261a" strokeWidth="2.2" />

      {/* Highway Directional Arrow Sign */}
      <rect x="1156" y="186" width="6" height="48" fill="#495057" />
      <rect x="1132" y="158" width="54" height="30" rx="6" fill="#78be21" stroke="#1c261a" strokeWidth="2.2" />
      <path
        d="M1146 173H1172M1164 165L1172 173L1164 181"
        stroke="#ffffff"
        strokeWidth="3"
        strokeLinecap="round"
        strokeLinejoin="round"
      />

      <rect x="1310" y="196" width="8" height="36" fill="#6f4518" />
      <circle cx="1314" cy="178" r="22" fill="#5e9c16" stroke="#1c261a" strokeWidth="2.2" />

      {/* ====================================================================
          PART 3 (x: 1460 - 2340): REALISTIC CITY SKYLINE & WATERFRONT BAY
         ==================================================================== */}
      {/* Sparkling Waterfront Bay Horizon (Left & Right of City Pier) */}
      <path d="M1440 212H2360V244H1440V212Z" fill="url(#bayWaterGrad)" />
      {/* Gentle Water Wave Ripples */}
      <path d="M1465 224C1480 220 1495 228 1510 224" stroke="#ffffff" strokeWidth="2" strokeLinecap="round" strokeOpacity="0.75" />
      <path d="M2140 222C2158 218 2176 226 2194 222" stroke="#ffffff" strokeWidth="2" strokeLinecap="round" strokeOpacity="0.75" />
      <path d="M2220 232C2238 228 2256 236 2274 232" stroke="#ffffff" strokeWidth="2" strokeLinecap="round" strokeOpacity="0.65" />

      {/* Sailboat gliding across the Bay */}
      <g transform="translate(2165, 162)">
        <path d="M4 44H56L48 54H12L4 44Z" fill="#b83a2d" stroke="#1c261a" strokeWidth="2" />
        <line x1="30" y1="8" x2="30" y2="44" stroke="#1c261a" strokeWidth="2.2" />
        <polygon points="30,10 52,38 30,38" fill="#ffffff" stroke="#1c261a" strokeWidth="2" />
        <polygon points="27,16 10,38 27,38" fill="#f3fae8" stroke="#1c261a" strokeWidth="1.8" />
      </g>

      {/* Harbor Lighthouse on Left Breakwater */}
      <g transform="translate(1474, 114)">
        <polygon points="14,98 20,24 36,24 42,98" fill="#ffffff" stroke="#1c261a" strokeWidth="2.2" />
        <polygon points="17,64 39,64 38,48 18,48" fill="#b83a2d" />
        <rect x="20" y="12" width="16" height="12" fill="#ffd166" stroke="#1c261a" strokeWidth="2" />
        <polygon points="16,12 28,2 40,12" fill="#b83a2d" stroke="#1c261a" strokeWidth="2" />
      </g>

      {/* City Promenade & Buildings (Centered at x = 1860 for 100% Arrival!) */}
      {/* Building A: Modern Glass & Brick City Apartment */}
      <rect x="1556" y="96" width="92" height="136" rx="4" fill="url(#glassTowerGrad)" stroke="#1c261a" strokeWidth="2.4" />
      <rect x="1556" y="96" width="92" height="14" fill="#1b4332" />
      <g fill="#ffffff" stroke="#78be21" strokeWidth="1.8">
        <rect x="1572" y="122" width="18" height="20" rx="2" />
        <rect x="1614" y="122" width="18" height="20" rx="2" />
        <rect x="1572" y="152" width="18" height="20" rx="2" />
        <rect x="1614" y="152" width="18" height="20" rx="2" />
      </g>
      <rect x="1590" y="192" width="24" height="40" fill="#d99b52" stroke="#1c261a" strokeWidth="2" />

      {/* Building B: Tall Downtown Skyscraper */}
      <rect x="1664" y="48" width="104" height="184" rx="4" fill="#ffffff" stroke="#1c261a" strokeWidth="2.4" />
      <rect x="1682" y="34" width="68" height="14" rx="2" fill="#2b2d42" stroke="#1c261a" strokeWidth="2" />
      <line x1="1716" y1="14" x2="1716" y2="34" stroke="#1c261a" strokeWidth="2.4" />
      <g fill="#eef7f2" stroke="#4ea8de" strokeWidth="1.8">
        <rect x="1682" y="66" width="20" height="22" rx="2" />
        <rect x="1730" y="66" width="20" height="22" rx="2" />
        <rect x="1682" y="100" width="20" height="22" rx="2" />
        <rect x="1730" y="100" width="20" height="22" rx="2" />
        <rect x="1682" y="134" width="20" height="22" rx="2" />
        <rect x="1730" y="134" width="20" height="22" rx="2" />
      </g>
      <path d="M1676 180H1756L1764 196H1668L1676 180Z" fill="#b83a2d" stroke="#1c261a" strokeWidth="2" />
      <rect x="1700" y="196" width="32" height="36" fill="#f8f9fa" stroke="#1c261a" strokeWidth="2" />

      {/* Building C: FARM2BAY HARBOR MARKET BAY (Centered at x = 1860!) */}
      <rect x="1792" y="116" width="136" height="116" rx="5" fill="#ffffff" stroke="#1c261a" strokeWidth="2.5" />
      {/* Striped Awning */}
      <path d="M1784 152H1936L1944 172H1776L1784 152Z" fill="#78be21" stroke="#1c261a" strokeWidth="2.2" />
      <line x1="1814" y1="152" x2="1810" y2="172" stroke="#ffffff" strokeWidth="5" />
      <line x1="1860" y1="152" x2="1860" y2="172" stroke="#ffffff" strokeWidth="5" />
      <line x1="1906" y1="152" x2="1910" y2="172" stroke="#ffffff" strokeWidth="5" />
      {/* Fresh Display Crates outside Market Bay */}
      <rect x="1806" y="204" width="34" height="26" rx="3" fill="#dfa357" stroke="#1c261a" strokeWidth="2" />
      <circle cx="1816" cy="200" r="7" fill="#78be21" stroke="#1c261a" strokeWidth="1.8" />
      <circle cx="1830" cy="200" r="7" fill="#e63946" stroke="#1c261a" strokeWidth="1.8" />

      <rect x="1880" y="204" width="34" height="26" rx="3" fill="#dfa357" stroke="#1c261a" strokeWidth="2" />
      <circle cx="1890" cy="200" r="7" fill="#f77f00" stroke="#1c261a" strokeWidth="1.8" />
      <circle cx="1904" cy="200" r="7" fill="#78be21" stroke="#1c261a" strokeWidth="1.8" />

      {/* Destination Location Drop-Pin directly above Bay */}
      <path
        d="M1860 54C1847 54 1837 64 1837 77C1837 93 1860 111 1860 111C1860 111 1883 93 1883 77C1883 64 1873 54 1860 54Z"
        fill="#b83a2d"
        stroke="#1c261a"
        strokeWidth="2.4"
      />
      <circle cx="1860" cy="76" r="7.5" fill="#ffffff" />

      {/* Building D: Harborfront Office */}
      <rect x="1952" y="84" width="96" height="148" rx="4" fill="url(#glassTowerGrad)" stroke="#1c261a" strokeWidth="2.4" />
      <g fill="#ffffff" stroke="#78be21" strokeWidth="1.8">
        <rect x="1970" y="106" width="20" height="24" rx="2" />
        <rect x="2010" y="106" width="20" height="24" rx="2" />
        <rect x="1970" y="144" width="20" height="24" rx="2" />
        <rect x="2010" y="144" width="20" height="24" rx="2" />
      </g>
    </svg>
  );
}

/* =========================================================
   3. REALISTIC HERITAGE RED & CREAM PICKUP TRUCK (NO GREEN BODY)
   ========================================================= */
export function FarmTruckIllustration({ className = '' }) {
  return (
    <svg
      viewBox="0 0 400 202"
      className={className}
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      aria-label="Farm2Bay Heritage Pickup Truck"
    >
      <defs>
        {/* Realistic Glossy Heritage Cherry-Red Metallic Body Gradient */}
        <linearGradient id="redTruckBody" x1="0" y1="52" x2="0" y2="152" gradientUnits="userSpaceOnUse">
          <stop offset="0%" stopColor="#d94e3f" />
          <stop offset="48%" stopColor="#b83a2d" />
          <stop offset="100%" stopColor="#7f2017" />
        </linearGradient>

        {/* Chrome Metallic Gradient */}
        <linearGradient id="chromeMetal" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0%" stopColor="#ffffff" />
          <stop offset="50%" stopColor="#ced4da" />
          <stop offset="100%" stopColor="#868e96" />
        </linearGradient>

        {/* Glass Window Reflection */}
        <linearGradient id="cabGlassGrad" x1="190" y1="64" x2="264" y2="96" gradientUnits="userSpaceOnUse">
          <stop offset="0%" stopColor="#e8f6f8" />
          <stop offset="55%" stopColor="#ffffff" />
          <stop offset="100%" stopColor="#cde6ec" />
        </linearGradient>

        {/* Headlight Warm Beam */}
        <linearGradient id="headlightCone" x1="348" y1="116" x2="400" y2="124" gradientUnits="userSpaceOnUse">
          <stop offset="0%" stopColor="#ffd166" stopOpacity="0.6" />
          <stop offset="100%" stopColor="#ffd166" stopOpacity="0" />
        </linearGradient>
      </defs>

      {/* Headlight Beam */}
      <polygon points="346,108 400,94 400,140 346,126" fill="url(#headlightCone)" />

      {/* Exhaust Puffs */}
      <circle className="exhaust-puff puff-1" cx="28" cy="152" r="6" fill="#dee2e6" />
      <circle className="exhaust-puff puff-2" cx="14" cy="144" r="9" fill="#e9ecef" />
      <circle className="exhaust-puff puff-3" cx="4" cy="135" r="11" fill="#f1f3f5" />

      {/* Realistic Ground Contact Shadow */}
      <ellipse cx="196" cy="183" rx="160" ry="8.5" fill="#1c261a" fillOpacity="0.22" />

      {/* Farm Goods Loaded in Truck Bed */}
      <g className="truck-cargo">
        {/* Fresh Glass Milk Bottles */}
        <rect x="64" y="54" width="22" height="40" rx="4" fill="#ffffff" stroke="#1c261a" strokeWidth="2.4" />
        <rect x="68" y="47" width="14" height="8" rx="2" fill="#78be21" stroke="#1c261a" strokeWidth="2" />
        <rect x="68" y="68" width="14" height="14" rx="2" fill="#eef7e1" />

        {/* Terracotta & Spice Jar */}
        <rect x="92" y="60" width="26" height="34" rx="6" fill="#e07a5f" stroke="#1c261a" strokeWidth="2.4" />
        <rect x="95" y="54" width="20" height="7" rx="2" fill="#f4a261" stroke="#1c261a" strokeWidth="2" />

        {/* Fresh Organic Greens & Carrots */}
        <circle cx="136" cy="69" r="18" fill="#78be21" stroke="#1c261a" strokeWidth="2.4" />
        <circle cx="154" cy="74" r="14" fill="#558b15" stroke="#1c261a" strokeWidth="2.4" />
        <path d="M124 53C121 40 130 36 135 48" stroke="#2d6a4f" strokeWidth="2.5" strokeLinecap="round" />
        <path d="M146 59L155 43" stroke="#f77f00" strokeWidth="4.5" strokeLinecap="round" />
      </g>

      {/* Golden Oak Wooden Stake-Bed Planks with Bolts */}
      <rect x="48" y="77" width="132" height="11" rx="2" fill="#e5aa5c" stroke="#1c261a" strokeWidth="2.4" />
      <rect x="48" y="93" width="132" height="11" rx="2" fill="#c88336" stroke="#1c261a" strokeWidth="2.4" />
      <rect x="58" y="74" width="9" height="36" fill="#b36d25" stroke="#1c261a" strokeWidth="2" />
      <rect x="114" y="74" width="9" height="36" fill="#b36d25" stroke="#1c261a" strokeWidth="2" />
      <rect x="164" y="74" width="9" height="36" fill="#b36d25" stroke="#1c261a" strokeWidth="2" />
      {/* Metal Rivet Bolts */}
      <circle cx="62.5" cy="82.5" r="1.5" fill="#1c261a" />
      <circle cx="118.5" cy="82.5" r="1.5" fill="#1c261a" />
      <circle cx="168.5" cy="82.5" r="1.5" fill="#1c261a" />

      {/* Exhaust Tailpipe */}
      <path d="M36 148H48V154H36C34 154 34 148 36 148Z" fill="url(#chromeMetal)" stroke="#1c261a" strokeWidth="2" />

      {/* Main Vintage Pickup Truck Body (Glossy Heritage Red) */}
      <path
        d="M44 108H182V64C182 55 189 48 198 48H245C256 48 265 55 270 66L282 96H332C343 96 352 105 352 116V150H44V108Z"
        fill="url(#redTruckBody)"
        stroke="#1c261a"
        strokeWidth="3"
        strokeLinejoin="round"
      />

      {/* Classic Warm Cream Two-Tone Cab Roof */}
      <path
        d="M184 64C184 55 190 49 198 49H245C255 49 264 55 269 65H184V64Z"
        fill="#faf6ee"
        stroke="#1c261a"
        strokeWidth="2.4"
      />

      {/* Cab Window + Diagonal Glass Glare + Driver */}
      <path
        d="M194 66H247C253 66 258 70 261 76L268 94H194V66Z"
        fill="url(#cabGlassGrad)"
        stroke="#1c261a"
        strokeWidth="2.4"
        strokeLinejoin="round"
      />
      {/* Diagonal Glass Highlight */}
      <polygon points="202,68 212,68 204,92 196,92" fill="#ffffff" fillOpacity="0.65" />

      {/* Driver Silhouette */}
      <circle cx="240" cy="80" r="6.5" fill="#f2c6a0" stroke="#1c261a" strokeWidth="1.8" />
      <path d="M233 77C233 72 237 70 241 70C245 70 248 72 248 77H233Z" fill="#1b4332" />
      <line x1="247" y1="77" x2="252" y2="77" stroke="#1b4332" strokeWidth="2.2" strokeLinecap="round" />
      <line x1="227" y1="66" x2="227" y2="94" stroke="#1c261a" strokeWidth="2.2" />

      {/* Chrome Side Mirror */}
      <rect x="262" y="77" width="6" height="12" rx="2" fill="url(#chromeMetal)" stroke="#1c261a" strokeWidth="1.8" />

      {/* Cream Two-Tone Side Spear Trim & Chrome Door Handle */}
      <path d="M52 125H344" stroke="#faf6ee" strokeWidth="4.5" />
      <path d="M52 125H344" stroke="#1c261a" strokeWidth="1.2" />
      <rect x="202" y="109" width="13" height="4.5" rx="2" fill="url(#chromeMetal)" stroke="#1c261a" strokeWidth="1.5" />

      {/* Sculpted Fender Wheel Arches */}
      <path
        d="M70 150C70 131 85 118 102 118C119 118 134 131 134 150"
        fill="#1c261a"
        stroke="#faf6ee"
        strokeWidth="2.8"
      />
      <path
        d="M258 150C258 131 273 118 290 118C307 118 322 131 322 150"
        fill="#1c261a"
        stroke="#faf6ee"
        strokeWidth="2.8"
      />

      {/* Chrome Bumpers, Front Grille Accent & Amber Headlight */}
      <rect x="36" y="140" width="16" height="12" rx="5" fill="url(#chromeMetal)" stroke="#1c261a" strokeWidth="2.4" />
      <rect x="342" y="140" width="18" height="12" rx="5" fill="url(#chromeMetal)" stroke="#1c261a" strokeWidth="2.4" />
      <rect x="344" y="108" width="9" height="16" rx="4" fill="#ffd166" stroke="#1c261a" strokeWidth="2.2" />

      {/* Rear Spinning Whitewall Wheel */}
      <g className="wheel-spin" style={{ transformOrigin: '102px 152px' }}>
        <circle cx="102" cy="152" r="26" fill="#212529" stroke="#1c261a" strokeWidth="3" />
        <circle
          cx="102"
          cy="152"
          r="23"
          stroke="#495057"
          strokeWidth="2.5"
          strokeDasharray="5 5"
        />
        <circle cx="102" cy="152" r="16" fill="#faf6ee" stroke="#1c261a" strokeWidth="2" />
        <circle cx="102" cy="152" r="10" fill="#b83a2d" stroke="#1c261a" strokeWidth="2" />
        <circle cx="102" cy="152" r="4.8" fill="url(#chromeMetal)" stroke="#1c261a" strokeWidth="1.6" />
        <line x1="102" y1="136" x2="102" y2="168" stroke="#1c261a" strokeWidth="1.6" />
        <line x1="86" y1="152" x2="118" y2="152" stroke="#1c261a" strokeWidth="1.6" />
      </g>

      {/* Front Spinning Whitewall Wheel */}
      <g className="wheel-spin" style={{ transformOrigin: '290px 152px' }}>
        <circle cx="290" cy="152" r="26" fill="#212529" stroke="#1c261a" strokeWidth="3" />
        <circle
          cx="290"
          cy="152"
          r="23"
          stroke="#495057"
          strokeWidth="2.5"
          strokeDasharray="5 5"
        />
        <circle cx="290" cy="152" r="16" fill="#faf6ee" stroke="#1c261a" strokeWidth="2" />
        <circle cx="290" cy="152" r="10" fill="#b83a2d" stroke="#1c261a" strokeWidth="2" />
        <circle cx="290" cy="152" r="4.8" fill="url(#chromeMetal)" stroke="#1c261a" strokeWidth="1.6" />
        <line x1="290" y1="136" x2="290" y2="168" stroke="#1c261a" strokeWidth="1.6" />
        <line x1="274" y1="152" x2="306" y2="152" stroke="#1c261a" strokeWidth="1.6" />
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

      <rect x="272" y="108" width="48" height="68" rx="12" fill="#b83a2d" stroke="#1c261a" strokeWidth="2.8" />
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
      <rect x="82" y="48" width="30" height="42" rx="8" fill="#b83a2d" stroke="#1c261a" strokeWidth="2.4" />
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
      <path d="M72 44C72 32 80 25 90 25C100 25 108 32 108 44H72Z" fill="#b83a2d" stroke="#1c261a" strokeWidth="2.4" />
      <path d="M74 44H116C116 48 107 50 94 50" fill="#852117" stroke="#1c261a" strokeWidth="2" />
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