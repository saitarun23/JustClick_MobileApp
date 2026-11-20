import React, { useEffect, useState } from 'react';
import { FarmTruckIllustration } from './Illustrations';

const STAGES = [
  'Harvesting fresh produce & dairy at the farm...',
  'Farm2Bay truck cruising from farm to city...',
  'Arriving fresh at your neighborhood bay!',
];

export default function SplashScreen({ onFinish }) {
  const [progress, setProgress] = useState(0);
  const [exiting, setExiting] = useState(false);

  useEffect(() => {
    const duration = 3600; // 3.6 seconds farm-to-city drive
    const startTime = performance.now();
    let frameId;

    const tick = (now) => {
      const elapsed = now - startTime;
      const pct = Math.min(100, Math.round((elapsed / duration) * 100));
      setProgress(pct);

      if (pct < 100) {
        frameId = requestAnimationFrame(tick);
      } else {
        setTimeout(() => {
          setExiting(true);
          setTimeout(onFinish, 450);
        }, 250);
      }
    };

    frameId = requestAnimationFrame(tick);
    return () => cancelAnimationFrame(frameId);
  }, [onFinish]);

  const stageIndex = progress < 35 ? 0 : progress < 78 ? 1 : 2;

  return (
    <div className={`splash-overlay ${exiting ? 'splash-exit' : ''}`}>
      <button
        type="button"
        className="splash-skip-btn"
        onClick={() => {
          setExiting(true);
          setTimeout(onFinish, 300);
        }}
      >
        Skip Intro →
      </button>

      {/* Top Brand Header */}
      <div className="splash-header">
        <span className="splash-pill">FARMER&apos;S MARKET EXPRESS</span>
        <h1 className="splash-title">
          Farm<span>2</span>Bay
        </h1>
        <p className="splash-subtitle">
          Dairy • Organic Vegetables • Traditional Pickles • Stone-Ground Powders
        </p>
      </div>

      {/* Scenic Farm-to-City Journey Stage */}
      <div className="journey-stage">
        {/* Left: Farm Hills & Barn */}
        <div className="scenery-farm" aria-hidden="true">
          <svg viewBox="0 0 240 160" fill="none">
            <circle cx="48" cy="36" r="18" fill="#ffd166" />
            <path d="M0 130C45 86 115 92 175 135H0V130Z" fill="#78be21" fillOpacity="0.28" />
            {/* Red Barn */}
            <rect x="44" y="76" width="52" height="44" fill="#d95d39" stroke="#1e2a1c" strokeWidth="2.5" />
            <path d="M38 78L70 52L102 78H38Z" fill="#b51717" stroke="#1e2a1c" strokeWidth="2.5" />
            <rect x="62" y="94" width="16" height="26" fill="#faf7f0" stroke="#1e2a1c" strokeWidth="2" />
            <text x="42" y="148" fill="#386641" fontSize="12" fontWeight="700">
              LOCAL FARMS
            </text>
          </svg>
        </div>

        {/* Right: Line-Art City Skyline (Inspired by Image 6) */}
        <div className="scenery-city" aria-hidden="true">
          <svg viewBox="0 0 260 160" fill="none">
            <g stroke="#78be21" strokeWidth="2.2" fill="#faf7f0">
              <rect x="44" y="46" width="44" height="78" rx="3" />
              <rect x="96" y="26" width="52" height="98" rx="3" />
              <rect x="156" y="56" width="48" height="68" rx="3" />
            </g>
            {/* City Windows */}
            <g fill="#78be21" fillOpacity="0.35">
              <rect x="54" y="58" width="8" height="10" />
              <rect x="70" y="58" width="8" height="10" />
              <rect x="54" y="76" width="8" height="10" />
              <rect x="70" y="76" width="8" height="10" />
              <rect x="108" y="40" width="10" height="12" />
              <rect x="126" y="40" width="10" height="12" />
              <rect x="108" y="60" width="10" height="12" />
              <rect x="126" y="60" width="10" height="12" />
              <rect x="168" y="68" width="9" height="10" />
              <rect x="184" y="68" width="9" height="10" />
            </g>
            <text x="106" y="148" fill="#386641" fontSize="12" fontWeight="700">
              YOUR CITY BAY
            </text>
          </svg>
        </div>

        {/* Moving Pickup Truck */}
        <div
          className="truck-track"
          style={{
            left: `calc(${progress * 0.72}% + 2%)`,
          }}
        >
          <div className="truck-bounce">
            <FarmTruckIllustration className="splash-truck-svg" />
          </div>
        </div>

        {/* Country-to-City Road */}
        <div className="journey-road">
          <div className="road-dashes" />
        </div>
      </div>

      {/* Progress Bar & Live Status */}
      <div className="splash-footer">
        <p className="splash-status">{STAGES[stageIndex]}</p>
        <div className="splash-progress-track">
          <div className="splash-progress-fill" style={{ width: `${progress}%` }} />
        </div>
      </div>
    </div>
  );
}