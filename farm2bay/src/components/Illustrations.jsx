import React from 'react';

/* =========================================================
   1. BRAND LOGO MARK & SPLASH VINTAGE TITLE (NO TEXT LABELS)
   ========================================================= */
export function Farm2BayLogoMark({ size = 40 }) {
  return (
    <svg
      width={size}
      height={size}
      viewBox="0 0 48 48"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      aria-hidden="true"
    >
      <rect
        x="3"
        y="3"
        width="42"
        height="42"
        rx="12"
        fill="#78be21"
        stroke="#1c261a"
        strokeWidth="3"
      />
      {/* Leaf Sprout */}
      <path
        d="M24 27C24 19 30 14 36 14C36 21 31 27 24 27Z"
        fill="#ffffff"
        stroke="#1c261a"
        strokeWidth="2.4"
        strokeLinejoin="round"
      />
      <path
        d="M24 27C24 21 19 17 13 17C13 23 18 27 24 27Z"
        fill="#dff2c2"
        stroke="#1c261a"
        strokeWidth="2.4"
        strokeLinejoin="round"
      />
      {/* Wooden Crate Base */}
      <rect
        x="12"
        y="28"
        width="24"
        height="9"
        rx="2.5"
        fill="#dda15e"
        stroke="#1c261a"
        strokeWidth="2.4"
      />
      <line x1="24" y1="25" x2="24" y2="28" stroke="#1c261a" strokeWidth="2.4" />
    </svg>
  );
}

export function SplashVintageTitle() {
  return (
    <div className="splash-brand-lockup">
      <Farm2BayLogoMark size={64} />
      <svg
        viewBox="0 0 460 112"
        className="vintage-title-svg"
        role="img"
        aria-label="FARM2BAY"
      >
        <defs>
          {/* Subtle Vintage Print Texture matching Farmer's Market poster */}
          <filter id="vintage-stamp" x="-5%" y="-5%" width="110%" height="110%">
            <feTurbulence
              type="fractalNoise"
              baseFrequency="0.65"
              numOctaves="2"
              result="noise"
            />
            <feDisplacementMap
              in="SourceGraphic"
              in2="noise"
              scale="1.6"
              xChannelSelector="R"
              yChannelSelector="G"
            />
          </filter>
        </defs>

        <g filter="url(#vintage-stamp)">
          <text
            x="230"
            y="88"
            textAnchor="middle"
            fontFamily="'Anton', Impact, sans-serif"
            fontSize="88"
            letterSpacing="4"
            fill="#1c261a"
          >
            FARM
            <tspan fill="#78be21">2</tspan>
            BAY
          </text>
        </g>
      </svg>
    </div>
  );
}

/* =========================================================
   2. PURE VISUAL FARM & CITY SCENERY FOR SPLASH (ZERO TEXT)
   ========================================================= */
export function FarmSceneIllustration() {
  return (
    <svg viewBox="0 0 250 175" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
      {/* Sun */}
      <circle cx="48" cy="36" r="18" fill="#ffd166" stroke="#1c261a" strokeWidth="2.2" />
      {/* Rolling Green Hills */}
      <path
        d="M0 148C46 94 128 100 198 152H0V148Z"
        fill="#eef7e1"
        stroke="#78be21"
        strokeWidth="2.2"
      />
      <path
        d="M95 152C145 112 200 118 246 152H95Z"
        fill="#dff0c7"
      />

      {/* Windmill */}
      <path d="M132 124L140 72H148L156 124" stroke="#1c261a" strokeWidth="2.2" fill="#ffffff" />
      <g stroke="#1c261a" strokeWidth="2.2" strokeLinecap="round">
        <line x1="144" y1="72" x2="128" y2="56" />
        <line x1="144" y1="72" x2="160" y2="56" />
        <line x1="144" y1="72" x2="128" y2="88" />
        <line x1="144" y1="72" x2="160" y2="88" />
      </g>
      <circle cx="144" cy="72" r="4" fill="#78be21" stroke="#1c261a" strokeWidth="2" />

      {/* Classic Barn */}
      <rect x="42" y="84" width="62" height="52" fill="#d95d39" stroke="#1c261a" strokeWidth="2.5" />
      <path
        d="M35 86L73 56L111 86H35Z"
        fill="#b5381c"
        stroke="#1c261a"
        strokeWidth="2.5"
        strokeLinejoin="round"
      />
      {/* Barn White Doors */}
      <rect x="61" y="104" width="24" height="32" fill="#ffffff" stroke="#1c261a" strokeWidth="2.2" />
      <line x1="61" y1="104" x2="85" y2="136" stroke="#1c261a" strokeWidth="1.8" />
      <line x1="85" y1="104" x2="61" y2="136" stroke="#1c261a" strokeWidth="1.8" />

      {/* Farm Trees */}
      <circle cx="24" cy="112" r="16" fill="#78be21" stroke="#1c261a" strokeWidth="2.2" />
      <rect x="21" y="126" width="6" height="14" fill="#bc6c25" />
      <circle cx="182" cy="118" r="14" fill="#78be21" stroke="#1c261a" strokeWidth="2.2" />
      <rect x="179" y="130" width="6" height="12" fill="#bc6c25" />
    </svg>
  );
}

export function CitySceneIllustration() {
  return (
    <svg viewBox="0 0 260 175" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
      {/* Crisp Architectural City Line-Art (Inspired by Image 6) */}
      <g stroke="#78be21" strokeWidth="2.3" fill="#ffffff">
        <rect x="34" y="64" width="46" height="86" rx="3" />
        <rect x="88" y="34" width="56" height="116" rx="3" />
        <rect x="152" y="54" width="52" height="96" rx="3" />
        <rect x="210" y="78" width="36" height="72" rx="3" />
      </g>

      {/* Building Grid Windows */}
      <g stroke="#78be21" strokeWidth="1.8" fill="#f3fae8">
        <rect x="44" y="76" width="10" height="12" />
        <rect x="60" y="76" width="10" height="12" />
        <rect x="44" y="96" width="10" height="12" />
        <rect x="60" y="96" width="10" height="12" />

        <rect x="100" y="48" width="12" height="14" />
        <rect x="120" y="48" width="12" height="14" />
        <rect x="100" y="70" width="12" height="14" />
        <rect x="120" y="70" width="12" height="14" />
        <rect x="100" y="92" width="12" height="14" />
        <rect x="120" y="92" width="12" height="14" />

        <rect x="164" y="68" width="11" height="12" />
        <rect x="182" y="68" width="11" height="12" />
        <rect x="164" y="88" width="11" height="12" />
        <rect x="182" y="88" width="11" height="12" />
      </g>

      {/* Delivery Destination Pin */}
      <path
        d="M116 8C107 8 100 15 100 24C100 35 116 48 116 48C116 48 132 35 132 24C132 15 125 8 116 8Z"
        fill="#78be21"
        stroke="#1c261a"
        strokeWidth="2.2"
      />
      <circle cx="116" cy="23" r="5" fill="#ffffff" />
    </svg>
  );
}

/* =========================================================
   3. VINTAGE FARMER'S MARKET PICKUP TRUCK (IMAGE 4 STYLE)
   ========================================================= */
export function FarmTruckIllustration({ className = '' }) {
  return (
    <svg
      viewBox="0 0 360 190"
      className={className}
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      aria-label="Farm2Bay Pickup Truck"
    >
      {/* Exhaust Puffs */}
      <circle className="exhaust-puff puff-1" cx="24" cy="144" r="7" fill="#d9e8c8" />
      <circle className="exhaust-puff puff-2" cx="10" cy="136" r="10" fill="#e8f3dc" />

      {/* Ground Shadow */}
      <ellipse cx="182" cy="174" rx="148" ry="8" fill="#1c261a" fillOpacity="0.12" />

      {/* Loaded Farm Goods in Truck Bed */}
      <g className="truck-cargo">
        {/* Glass Milk Bottle */}
        <rect x="64" y="54" width="22" height="36" rx="4" fill="#ffffff" stroke="#1c261a" strokeWidth="2.5" />
        <rect x="68" y="47" width="14" height="8" rx="2" fill="#78be21" stroke="#1c261a" strokeWidth="2.2" />
        {/* Pickle Jar */}
        <rect x="92" y="60" width="26" height="30" rx="6" fill="#e07a5f" stroke="#1c261a" strokeWidth="2.5" />
        <rect x="95" y="54" width="20" height="7" rx="2" fill="#f4a261" stroke="#1c261a" strokeWidth="2.2" />
        {/* Fresh Greens */}
        <circle cx="132" cy="68" r="16" fill="#78be21" stroke="#1c261a" strokeWidth="2.5" />
        <circle cx="147" cy="73" r="13" fill="#558b15" stroke="#1c261a" strokeWidth="2.5" />
        <path d="M122 54C120 42 128 38 133 48" stroke="#386641" strokeWidth="2.5" strokeLinecap="round" />
      </g>

      {/* Wooden Bed Slats */}
      <rect x="46" y="76" width="124" height="10" rx="2" fill="#dda15e" stroke="#1c261a" strokeWidth="2.5" />
      <rect x="46" y="91" width="124" height="10" rx="2" fill="#bc6c25" stroke="#1c261a" strokeWidth="2.5" />
      <rect x="56" y="73" width="8" height="35" fill="#bc6c25" stroke="#1c261a" strokeWidth="2.2" />
      <rect x="110" y="73" width="8" height="35" fill="#bc6c25" stroke="#1c261a" strokeWidth="2.2" />
      <rect x="156" y="73" width="8" height="35" fill="#bc6c25" stroke="#1c261a" strokeWidth="2.2" />

      {/* Vintage Pickup Body */}
      <path
        d="M42 106H172V64C172 56 178 50 186 50H234C244 50 252 57 256 67L266 94H314C324 94 332 102 332 112V144H42V106Z"
        fill="#78be21"
        stroke="#1c261a"
        strokeWidth="3"
        strokeLinejoin="round"
      />

      {/* Cabin Window */}
      <path
        d="M184 56H232C239 56 245 61 248 68L256 90H184V56Z"
        fill="#ffffff"
        stroke="#1c261a"
        strokeWidth="2.5"
        strokeLinejoin="round"
      />
      <line x1="218" y1="56" x2="218" y2="90" stroke="#1c261a" strokeWidth="2.5" />

      {/* Vintage Chrome Trim */}
      <line x1="52" y1="122" x2="322" y2="122" stroke="#1c261a" strokeWidth="2.2" />
      <rect x="196" y="109" width="38" height="7" rx="3.5" fill="#ffffff" stroke="#1c261a" strokeWidth="1.8" />

      {/* Bumpers & Headlight */}
      <rect x="34" y="135" width="14" height="10" rx="4" fill="#f1f3f5" stroke="#1c261a" strokeWidth="2.5" />
      <rect x="324" y="135" width="16" height="10" rx="4" fill="#f1f3f5" stroke="#1c261a" strokeWidth="2.5" />
      <rect x="326" y="106" width="8" height="14" rx="3" fill="#ffd166" stroke="#1c261a" strokeWidth="2.2" />

      {/* Rear Whitewall Wheel */}
      <g className="wheel-spin" style={{ transformOrigin: '96px 146px' }}>
        <circle cx="96" cy="146" r="24" fill="#232922" stroke="#1c261a" strokeWidth="3" />
        <circle cx="96" cy="146" r="15" fill="#ffffff" stroke="#1c261a" strokeWidth="2.2" />
        <circle cx="96" cy="146" r="7" fill="#78be21" stroke="#1c261a" strokeWidth="2" />
        <line x1="96" y1="131" x2="96" y2="161" stroke="#1c261a" strokeWidth="1.5" />
        <line x1="81" y1="146" x2="111" y2="146" stroke="#1c261a" strokeWidth="1.5" />
      </g>

      {/* Front Whitewall Wheel */}
      <g className="wheel-spin" style={{ transformOrigin: '274px 146px' }}>
        <circle cx="274" cy="146" r="24" fill="#232922" stroke="#1c261a" strokeWidth="3" />
        <circle cx="274" cy="146" r="15" fill="#ffffff" stroke="#1c261a" strokeWidth="2.2" />
        <circle cx="274" cy="146" r="7" fill="#78be21" stroke="#1c261a" strokeWidth="2" />
        <line x1="274" y1="131" x2="274" y2="161" stroke="#1c261a" strokeWidth="1.5" />
        <line x1="259" y1="146" x2="289" y2="146" stroke="#1c261a" strokeWidth="1.5" />
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
      {/* Floating Pastel Green Line-Art Veggies (Image 1 Style) */}
      <g stroke="#78be21" strokeWidth="2" strokeOpacity="0.55" strokeLinecap="round">
        <path d="M74 64C64 48 84 36 94 52C104 68 84 80 74 64Z" />
        <path d="M84 44L88 34" />
        <circle cx="384" cy="60" r="18" />
        <path d="M384 42C380 34 390 32 392 40" />
        <path d="M402 138C416 128 428 144 412 156C396 168 388 148 402 138Z" />
        <path d="M52 150C38 140 50 122 66 132C82 142 66 160 52 150Z" />
      </g>

      {/* Overflowing Produce, Milk Bottle & Pickle Jar */}
      <circle cx="176" cy="138" r="34" fill="#78be21" stroke="#1c261a" strokeWidth="2.8" />
      <circle cx="232" cy="124" r="38" fill="#558b15" stroke="#1c261a" strokeWidth="2.8" />
      <circle cx="286" cy="140" r="32" fill="#8ac926" stroke="#1c261a" strokeWidth="2.8" />

      {/* Milk Bottle */}
      <rect x="132" y="102" width="38" height="78" rx="8" fill="#ffffff" stroke="#1c261a" strokeWidth="2.8" />
      <rect x="139" y="88" width="24" height="15" rx="4" fill="#78be21" stroke="#1c261a" strokeWidth="2.5" />
      <rect x="138" y="128" width="26" height="24" rx="3" fill="#eef7e1" />

      {/* Carrot */}
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

      {/* Glass Pickle Jar */}
      <rect x="272" y="108" width="48" height="68" rx="12" fill="#e07a5f" stroke="#1c261a" strokeWidth="2.8" />
      <rect x="278" y="96" width="36" height="13" rx="4" fill="#f4a261" stroke="#1c261a" strokeWidth="2.5" />
      <rect x="280" y="128" width="32" height="22" rx="4" fill="#ffffff" stroke="#1c261a" strokeWidth="1.8" />

      {/* Ripe Tomato */}
      <circle cx="236" cy="162" r="24" fill="#e63946" stroke="#1c261a" strokeWidth="2.8" />
      <path d="M236 138L230 130M236 138L243 131" stroke="#386641" strokeWidth="2.8" strokeLinecap="round" />

      {/* Wooden Crate Slats */}
      <rect x="112" y="170" width="236" height="24" rx="4" fill="#dda15e" stroke="#1c261a" strokeWidth="2.8" />
      <rect x="112" y="202" width="236" height="24" rx="4" fill="#bc6c25" stroke="#1c261a" strokeWidth="2.8" />
      <rect x="112" y="234" width="236" height="24" rx="4" fill="#dda15e" stroke="#1c261a" strokeWidth="2.8" />
      <rect x="126" y="166" width="16" height="96" rx="3" fill="#b07d4f" stroke="#1c261a" strokeWidth="2.5" />
      <rect x="318" y="166" width="16" height="96" rx="3" fill="#b07d4f" stroke="#1c261a" strokeWidth="2.5" />

      {/* Left & Right Hands Holding Crate */}
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
   5. HOW IT WORKS STEP ILLUSTRATIONS (ZERO EMOJIS)
   ========================================================= */
export function HarvestStepIllustration() {
  return (
    <svg viewBox="0 0 180 140" className="step-svg" fill="none" xmlns="http://www.w3.org/2000/svg">
      <circle cx="90" cy="70" r="56" fill="#f3fae8" />
      {/* Sun & Sprouts */}
      <circle cx="122" cy="36" r="12" fill="#ffd166" stroke="#1c261a" strokeWidth="2.2" />
      <path d="M40 104C65 86 115 86 140 104" stroke="#78be21" strokeWidth="4" strokeLinecap="round" />
      {/* Fresh Carrot & Leafy Greens */}
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
      {/* Milk Bottle */}
      <rect x="52" y="42" width="24" height="48" rx="6" fill="#ffffff" stroke="#1c261a" strokeWidth="2.4" />
      <rect x="56" y="33" width="16" height="9" rx="3" fill="#78be21" stroke="#1c261a" strokeWidth="2" />
      {/* Pickle Jar */}
      <rect x="82" y="48" width="30" height="42" rx="8" fill="#e07a5f" stroke="#1c261a" strokeWidth="2.4" />
      <rect x="86" y="40" width="22" height="8" rx="3" fill="#f4a261" stroke="#1c261a" strokeWidth="2" />
      {/* Crate Base */}
      <rect x="44" y="84" width="92" height="14" rx="3" fill="#dda15e" stroke="#1c261a" strokeWidth="2.4" />
      <rect x="44" y="102" width="92" height="14" rx="3" fill="#bc6c25" stroke="#1c261a" strokeWidth="2.4" />
    </svg>
  );
}

export function DeliveryPartnerIllustration() {
  return (
    <svg viewBox="0 0 180 140" className="step-svg" fill="none" xmlns="http://www.w3.org/2000/svg">
      <circle cx="90" cy="70" r="56" fill="#f3fae8" />
      {/* Head & Red Cap (Image 5 Style) */}
      <circle cx="90" cy="48" r="18" fill="#f7cbb0" stroke="#1c261a" strokeWidth="2.4" />
      <path d="M72 44C72 32 80 25 90 25C100 25 108 32 108 44H72Z" fill="#d62828" stroke="#1c261a" strokeWidth="2.4" />
      <path d="M74 44H116C116 48 107 50 94 50" fill="#b51717" stroke="#1c261a" strokeWidth="2" />
      <circle cx="84" cy="49" r="2" fill="#1c261a" />
      <circle cx="96" cy="49" r="2" fill="#1c261a" />
      <path d="M85 56C88 59 92 59 95 56" stroke="#1c261a" strokeWidth="2" strokeLinecap="round" />

      {/* Veggies & Wooden Crate */}
      <circle cx="74" cy="78" r="10" fill="#78be21" stroke="#1c261a" strokeWidth="2.2" />
      <circle cx="91" cy="76" r="11" fill="#e63946" stroke="#1c261a" strokeWidth="2.2" />
      <circle cx="107" cy="79" r="9" fill="#f77f00" stroke="#1c261a" strokeWidth="2.2" />
      <rect x="56" y="84" width="68" height="11" rx="2.5" fill="#dda15e" stroke="#1c261a" strokeWidth="2.2" />
      <rect x="56" y="98" width="68" height="11" rx="2.5" fill="#bc6c25" stroke="#1c261a" strokeWidth="2.2" />
    </svg>
  );
}

/* =========================================================
   6. PRODUCT CATEGORY ILLUSTRATIONS & CLEAN UI ICONS
   ========================================================= */
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