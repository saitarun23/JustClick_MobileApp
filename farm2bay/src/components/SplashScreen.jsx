import React, { useEffect, useState } from 'react';
import {
  FarmTruckIllustration,
  PanoramicWorldIllustration,
  SplashVintageTitle,
} from './Illustrations';

export default function SplashScreen({ onFinish }) {
  const [progress, setProgress] = useState(0);
  const [exiting, setExiting] = useState(false);

  useEffect(() => {
    const duration = 4000; // 4.0s smooth Farm-to-Bay journey
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
        }, 320);
      }
    };

    frameId = requestAnimationFrame(tick);
    return () => cancelAnimationFrame(frameId);
  }, [onFinish]);

  return (
    <div className={`splash-overlay ${exiting ? 'splash-exit' : ''}`}>
      {/* Minimal Arrow Skip Icon */}
      <button
        type="button"
        className="splash-skip-icon"
        aria-label="Enter Store"
        onClick={() => {
          setExiting(true);
          setTimeout(onFinish, 280);
        }}
      >
        <svg
          width="20"
          height="20"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          strokeWidth="2.5"
          strokeLinecap="round"
          strokeLinejoin="round"
        >
          <line x1="5" y1="12" x2="19" y2="12" />
          <polyline points="12 5 19 12 12 19" />
        </svg>
      </button>

      {/* Top Brand Emblem & Farmer's Market Style FARM2BAY Title */}
      <div className="splash-center-brand">
        <SplashVintageTitle />
      </div>

      {/* Widescreen Cinematic Viewport: Fixed Center Truck + Scrolling Farm-to-Bay World */}
      <div className="cinematic-viewport">
        <div className="viewport-fade-left" />
        <div className="viewport-fade-right" />

        {/* Drifting Clouds */}
        <div className="sky-clouds-layer" aria-hidden="true">
          <svg viewBox="0 0 1400 90" fill="none">
            <path d="M140 55H210C218 55 224 49 224 41C224 34 218 28 211 28C208 18 199 12 188 12C175 12 165 22 164 34C151 35 140 44 140 55Z" fill="#f1f5f9" />
            <path d="M560 44H640C649 44 656 37 656 28C656 20 649 13 641 13C637 3 627 -3 615 -3C601 -3 589 8 588 21C573 22 560 32 560 44Z" fill="#f1f5f9" />
            <path d="M980 56H1055C1063 56 1070 49 1070 41C1070 33 1064 27 1056 27C1053 17 1043 11 1032 11C1018 11 1007 21 1006 34C992 35 980 44 980 56Z" fill="#f1f5f9" />
          </svg>
        </div>

        {/* Continuous Farm (x=540) -> Highway (x=1200) -> City Bay (x=1860) Panorama */}
        <div
          className="panorama-track"
          style={{
            transform: `translateX(-${progress * 13.2}px)`,
          }}
        >
          <PanoramicWorldIllustration />
        </div>

        {/* Fixed Center Heritage Pickup Truck (Spinning Wheels + Suspension Bounce) */}
        <div className="fixed-center-truck">
          <div className="truck-road-feel">
            <FarmTruckIllustration className="splash-truck-svg" />
          </div>
        </div>

        {/* Moving Asphalt Highway Road */}
        <div className="journey-road">
          <div className="road-shoulder" />
          <div className="road-dashes-scroll" />
        </div>
      </div>

      {/* Minimal Progress Bar */}
      <div className="splash-footer">
        <div className="splash-progress-track">
          <div className="splash-progress-fill" style={{ width: `${progress}%` }} />
        </div>
      </div>
    </div>
  );
}