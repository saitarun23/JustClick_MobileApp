import React from 'react';

export function FarmTruckIllustration({ className = '' }) {
  return (
    <svg
      viewBox="0 0 360 190"
      className={className}
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      aria-label="Farm2Bay Vintage Pickup Truck"
    >
      {/* Exhaust Puffs */}
      <circle className="exhaust-puff puff-1" cx="24" cy="144" r="7" fill="#d9e8c8" />
      <circle className="exhaust-puff puff-2" cx="10" cy="136" r="10" fill="#e6f1d8" />

      {/* Ground Shadow */}
      <ellipse cx="182" cy="174" rx="148" ry="8" fill="#1b4332" fillOpacity="0.16" />

      {/* Cargo inside truck bed (Veggies, Milk Bottle & Pickle Jar) */}
      <g className="truck-cargo">
        {/* Milk Bottle */}
        <rect x="64" y="54" width="22" height="36" rx="4" fill="#ffffff" stroke="#1e2a1c" strokeWidth="2.5" />
        <rect x="68" y="47" width="14" height="8" rx="2" fill="#78be21" stroke="#1e2a1c" strokeWidth="2.2" />
        {/* Pickle Jar */}
        <rect x="92" y="60" width="26" height="30" rx="6" fill="#e07a5f" stroke="#1e2a1c" strokeWidth="2.5" />
        <rect x="95" y="54" width="20" height="7" rx="2" fill="#f4a261" stroke="#1e2a1c" strokeWidth="2.2" />
        {/* Fresh Greens & Carrot */}
        <circle cx="132" cy="68" r="16" fill="#78be21" stroke="#1e2a1c" strokeWidth="2.5" />
        <circle cx="147" cy="73" r="13" fill="#568e14" stroke="#1e2a1c" strokeWidth="2.5" />
        <path d="M122 54C120 42 128 38 133 48" stroke="#386641" strokeWidth="2.5" strokeLinecap="round" />
      </g>

      {/* Wooden Bed Slats (Inspired by Farmer's Market Truck) */}
      <rect x="46" y="76" width="124" height="10" rx="2" fill="#dda15e" stroke="#1e2a1c" strokeWidth="2.5" />
      <rect x="46" y="91" width="124" height="10" rx="2" fill="#bc6c25" stroke="#1e2a1c" strokeWidth="2.5" />
      <rect x="56" y="73" width="8" height="35" fill="#bc6c25" stroke="#1e2a1c" strokeWidth="2.2" />
      <rect x="110" y="73" width="8" height="35" fill="#bc6c25" stroke="#1e2a1c" strokeWidth="2.2" />
      <rect x="156" y="73" width="8" height="35" fill="#bc6c25" stroke="#1e2a1c" strokeWidth="2.2" />

      {/* Truck Rear Bed & Cabin Body */}
      <path
        d="M42 106H172V64C172 56 178 50 186 50H234C244 50 252 57 256 67L266 94H314C324 94 332 102 332 112V144H42V106Z"
        fill="#78be21"
        stroke="#1e2a1c"
        strokeWidth="3"
        strokeLinejoin="round"
      />

      {/* Cabin Roof Highlight */}
      <path
        d="M184 56H232C239 56 245 61 248 68L256 90H184V56Z"
        fill="#eef6e6"
        stroke="#1e2a1c"
        strokeWidth="2.5"
        strokeLinejoin="round"
      />
      {/* Window Divider */}
      <line x1="218" y1="56" x2="218" y2="90" stroke="#1e2a1c" strokeWidth="2.5" />

      {/* Vintage Side Trim & Branding */}
      <line x1="52" y1="122" x2="322" y2="122" stroke="#1e2a1c" strokeWidth="2.2" />
      <text
        x="192"
        y="114"
        fill="#1e2a1c"
        fontSize="11"
        fontWeight="800"
        fontFamily="Plus Jakarta Sans, sans-serif"
      >
        FARM2BAY
      </text>

      {/* Bumpers & Headlight */}
      <rect x="34" y="135" width="14" height="10" rx="4" fill="#e9ecef" stroke="#1e2a1c" strokeWidth="2.5" />
      <rect x="324" y="135" width="16" height="10" rx="4" fill="#e9ecef" stroke="#1e2a1c" strokeWidth="2.5" />
      <rect x="326" y="106" width="8" height="14" rx="3" fill="#ffd166" stroke="#1e2a1c" strokeWidth="2.2" />

      {/* Rear Wheel */}
      <g className="wheel-spin" style={{ transformOrigin: '96px 146px' }}>
        <circle cx="96" cy="146" r="24" fill="#2b2d42" stroke="#1e2a1c" strokeWidth="3" />
        <circle cx="96" cy="146" r="15" fill="#faf7f0" stroke="#1e2a1c" strokeWidth="2.2" />
        <circle cx="96" cy="146" r="7" fill="#78be21" stroke="#1e2a1c" strokeWidth="2" />
        <line x1="96" y1="131" x2="96" y2="161" stroke="#1e2a1c" strokeWidth="1.5" />
        <line x1="81" y1="146" x2="111" y2="146" stroke="#1e2a1c" strokeWidth="1.5" />
      </g>

      {/* Front Wheel */}
      <g className="wheel-spin" style={{ transformOrigin: '274px 146px' }}>
        <circle cx="274" cy="146" r="24" fill="#2b2d42" stroke="#1e2a1c" strokeWidth="3" />
        <circle cx="274" cy="146" r="15" fill="#faf7f0" stroke="#1e2a1c" strokeWidth="2.2" />
        <circle cx="274" cy="146" r="7" fill="#78be21" stroke="#1e2a1c" strokeWidth="2" />
        <line x1="274" y1="131" x2="274" y2="161" stroke="#1e2a1c" strokeWidth="1.5" />
        <line x1="259" y1="146" x2="289" y2="146" stroke="#1e2a1c" strokeWidth="1.5" />
      </g>
    </svg>
  );
}

export function WoodenCrateHeroIllustration() {
  return (
    <svg
      viewBox="0 0 460 360"
      className="hero-crate-svg"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      aria-label="Hands holding wooden crate of organic farm goods"
    >
      {/* Floating Pastel Green Line-Art Veggies (Matching Image 1 & 3) */}
      <g stroke="#78be21" strokeWidth="2" strokeOpacity="0.45" strokeLinecap="round">
        <path d="M74 68C64 52 84 40 94 56C104 72 84 84 74 68Z" />
        <path d="M84 48L88 38" />
        <circle cx="384" cy="64" r="18" />
        <path d="M384 46C380 38 390 36 392 44" />
        <path d="M402 142C416 132 428 148 412 160C396 172 388 152 402 142Z" />
        <path d="M52 154C38 144 50 126 66 136C82 146 66 164 52 154Z" />
      </g>

      {/* Overflowing Produce, Milk Bottle & Pickle Jar inside Wooden Crate */}
      {/* Leafy Greens */}
      <circle cx="176" cy="142" r="34" fill="#78be21" stroke="#1e2a1c" strokeWidth="2.8" />
      <circle cx="232" cy="128" r="38" fill="#568e14" stroke="#1e2a1c" strokeWidth="2.8" />
      <circle cx="286" cy="144" r="32" fill="#8ac926" stroke="#1e2a1c" strokeWidth="2.8" />

      {/* Farm Milk Bottle */}
      <rect x="132" y="106" width="38" height="78" rx="8" fill="#ffffff" stroke="#1e2a1c" strokeWidth="2.8" />
      <rect x="139" y="92" width="24" height="15" rx="4" fill="#78be21" stroke="#1e2a1c" strokeWidth="2.5" />
      <rect x="138" y="132" width="26" height="24" rx="3" fill="#eef6e6" />

      {/* Carrot */}
      <path
        d="M192 94L214 176L172 170L192 94Z"
        fill="#f77f00"
        stroke="#1e2a1c"
        strokeWidth="2.8"
        strokeLinejoin="round"
      />
      <path d="M192 94C186 76 176 74 182 90M192 94C194 74 204 74 198 90" stroke="#386641" strokeWidth="2.8" strokeLinecap="round" />

      {/* Glass Pickle Jar */}
      <rect x="272" y="112" width="48" height="68" rx="12" fill="#e07a5f" stroke="#1e2a1c" strokeWidth="2.8" />
      <rect x="278" y="100" width="36" height="13" rx="4" fill="#f4a261" stroke="#1e2a1c" strokeWidth="2.5" />
      <rect x="280" y="132" width="32" height="22" rx="4" fill="#faf7f0" stroke="#1e2a1c" strokeWidth="1.8" />

      {/* Ripe Tomato & Bell Pepper */}
      <circle cx="236" cy="166" r="24" fill="#e63946" stroke="#1e2a1c" strokeWidth="2.8" />
      <path d="M236 142L230 134M236 142L243 135" stroke="#386641" strokeWidth="2.8" strokeLinecap="round" />

      {/* Wooden Crate Slats */}
      <rect x="112" y="174" width="236" height="24" rx="4" fill="#dda15e" stroke="#1e2a1c" strokeWidth="2.8" />
      <rect x="112" y="206" width="236" height="24" rx="4" fill="#bc6c25" stroke="#1e2a1c" strokeWidth="2.8" />
      <rect x="112" y="238" width="236" height="24" rx="4" fill="#dda15e" stroke="#1e2a1c" strokeWidth="2.8" />
      {/* Vertical Crate Posts */}
      <rect x="126" y="170" width="16" height="96" rx="3" fill="#b07d4f" stroke="#1e2a1c" strokeWidth="2.5" />
      <rect x="318" y="170" width="16" height="96" rx="3" fill="#b07d4f" stroke="#1e2a1c" strokeWidth="2.5" />

      {/* Left & Right Welcoming Hands Holding Crate (Inspired by Image 1) */}
      <path
        d="M12 248L98 256C116 258 134 246 154 246C166 246 172 256 160 264L124 274L164 276C174 277 174 289 162 290L116 292L16 306"
        fill="#f2c6a0"
        stroke="#1e2a1c"
        strokeWidth="2.8"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
      <path
        d="M448 248L362 256C344 258 326 246 306 246C294 246 288 256 300 264L336 274L296 276C286 277 286 289 298 290L344 292L444 306"
        fill="#f2c6a0"
        stroke="#1e2a1c"
        strokeWidth="2.8"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
}

export function DeliveryPartnerIllustration() {
  return (
    <svg viewBox="0 0 220 220" className="step-svg" fill="none" xmlns="http://www.w3.org/2000/svg">
      <circle cx="110" cy="110" r="96" fill="#eef6e6" />
      {/* Delivery Person Torso */}
      <path d="M58 188C62 146 82 132 110 132C138 132 158 146 162 188" fill="#2b59c3" stroke="#1e2a1c" strokeWidth="2.8" />
      {/* Head */}
      <circle cx="110" cy="92" r="26" fill="#f7cbb0" stroke="#1e2a1c" strokeWidth="2.8" />
      {/* Red Cap (Matching Image 5) */}
      <path d="M84 86C84 68 96 58 110 58C124 58 136 68 136 86H84Z" fill="#d62828" stroke="#1e2a1c" strokeWidth="2.8" />
      <path d="M86 86H146C146 92 134 95 114 95" fill="#b51717" stroke="#1e2a1c" strokeWidth="2.5" />
      {/* Smile & Eyes */}
      <circle cx="101" cy="93" r="2.5" fill="#1e2a1c" />
      <circle cx="119" cy="93" r="2.5" fill="#1e2a1c" />
      <path d="M103 103C107 108 113 108 117 103" stroke="#1e2a1c" strokeWidth="2.5" strokeLinecap="round" />

      {/* Veggies in Crate */}
      <circle cx="88" cy="136" r="14" fill="#78be21" stroke="#1e2a1c" strokeWidth="2.5" />
      <circle cx="112" cy="134" r="15" fill="#e63946" stroke="#1e2a1c" strokeWidth="2.5" />
      <circle cx="134" cy="137" r="13" fill="#f77f00" stroke="#1e2a1c" strokeWidth="2.5" />

      {/* Wooden Crate */}
      <rect x="64" y="142" width="92" height="14" rx="3" fill="#dda15e" stroke="#1e2a1c" strokeWidth="2.5" />
      <rect x="64" y="160" width="92" height="14" rx="3" fill="#bc6c25" stroke="#1e2a1c" strokeWidth="2.5" />
      <rect x="64" y="178" width="92" height="14" rx="3" fill="#dda15e" stroke="#1e2a1c" strokeWidth="2.5" />
    </svg>
  );
}

export function ProductIllustration({ category, accent = '#78be21' }) {
  switch (category) {
    case 'dairy':
      return (
        <svg viewBox="0 0 140 120" className="product-svg" fill="none">
          <circle cx="70" cy="60" r="46" fill="#eef6e6" />
          {/* Milk Bottle */}
          <rect x="44" y="34" width="30" height="58" rx="7" fill="#ffffff" stroke="#1e2a1c" strokeWidth="2.5" />
          <rect x="49" y="24" width="20" height="11" rx="3" fill="#78be21" stroke="#1e2a1c" strokeWidth="2.2" />
          <rect x="49" y="54" width="20" height="18" rx="3" fill={accent} fillOpacity="0.28" />
          {/* Cream / Ghee Pot */}
          <rect x="78" y="56" width="28" height="36" rx="8" fill={accent} stroke="#1e2a1c" strokeWidth="2.5" />
          <rect x="81" y="49" width="22" height="8" rx="3" fill="#faf7f0" stroke="#1e2a1c" strokeWidth="2.2" />
        </svg>
      );

    case 'vegetables':
      return (
        <svg viewBox="0 0 140 120" className="product-svg" fill="none">
          <circle cx="70" cy="60" r="46" fill="#eef6e6" />
          <circle cx="56" cy="56" r="22" fill="#78be21" stroke="#1e2a1c" strokeWidth="2.5" />
          <circle cx="84" cy="62" r="20" fill={accent} stroke="#1e2a1c" strokeWidth="2.5" />
          <path d="M66 32L76 88L54 86L66 32Z" fill="#f77f00" stroke="#1e2a1c" strokeWidth="2.5" strokeLinejoin="round" />
          <path d="M66 32C62 22 56 22 60 30M66 32C68 20 74 22 70 30" stroke="#386641" strokeWidth="2.5" strokeLinecap="round" />
        </svg>
      );

    case 'pickles':
      return (
        <svg viewBox="0 0 140 120" className="product-svg" fill="none">
          <circle cx="70" cy="60" r="46" fill="#fdf1e6" />
          {/* Traditional Glass Pickle Jar */}
          <rect x="46" y="36" width="48" height="58" rx="12" fill={accent} stroke="#1e2a1c" strokeWidth="2.5" />
          <rect x="51" y="25" width="38" height="12" rx="4" fill="#78be21" stroke="#1e2a1c" strokeWidth="2.5" />
          <rect x="54" y="52" width="32" height="24" rx="4" fill="#faf7f0" stroke="#1e2a1c" strokeWidth="2" />
          <line x1="60" y1="61" x2="80" y2="61" stroke="#1e2a1c" strokeWidth="2" strokeLinecap="round" />
          <line x1="63" y1="68" x2="77" y2="68" stroke="#78be21" strokeWidth="2" strokeLinecap="round" />
        </svg>
      );

    case 'powders':
      return (
        <svg viewBox="0 0 140 120" className="product-svg" fill="none">
          <circle cx="70" cy="60" r="46" fill="#f8f2e4" />
          {/* Kraft Spice Pouch */}
          <path
            d="M46 28H94L98 90C98 93 95 96 92 96H48C45 96 42 93 42 90L46 28Z"
            fill="#e6ccb2"
            stroke="#1e2a1c"
            strokeWidth="2.5"
          />
          <line x1="45" y1="38" x2="95" y2="38" stroke="#1e2a1c" strokeWidth="2" />
          <circle cx="70" cy="66" r="16" fill={accent} stroke="#1e2a1c" strokeWidth="2.2" />
          <path d="M58 84C64 78 76 78 82 84" stroke="#78be21" strokeWidth="2.5" strokeLinecap="round" />
        </svg>
      );

    default:
      return (
        <svg viewBox="0 0 140 120" className="product-svg" fill="none">
          <circle cx="70" cy="60" r="46" fill="#eef6e6" />
          <rect x="44" y="42" width="32" height="50" rx="9" fill={accent} stroke="#1e2a1c" strokeWidth="2.5" />
          <rect x="49" y="33" width="22" height="10" rx="3" fill="#faf7f0" stroke="#1e2a1c" strokeWidth="2.2" />
          <path d="M74 72C74 56 102 56 102 72V92H74V72Z" fill="#dda15e" stroke="#1e2a1c" strokeWidth="2.5" />
        </svg>
      );
  }
}