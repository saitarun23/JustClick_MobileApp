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
    const duration = 3800; // 3.8s smooth cinematic farm-to-city journey
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
        }, 280);
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

      {/* Top Vintage Brand Lockup */}
      <div className="splash-center-brand">
        <SplashVintageTitle />
      </div>

      {/* Widescreen Cinematic Viewport: Fixed Center Truck + Scrolling World */}
      <div className="cinematic-viewport">
        {/* Soft Side Vignette Fade into Pure #FFFFFF Background */}
        <div className="viewport-fade-left" />
        <div className="viewport-fade-right" />

        {/* Slow Drifting Sky Clouds */}
        <div className="sky-clouds-layer" aria-hidden="true">
          <svg viewBox="0 0 1200 90" fill="none">
            <path d="M120 55H190C198 55 204 49 204 41C204 34 198 28 191 28C188 18 179 12 168 12C155 12 145 22 144 34C131 35 120 44 120 55Z" fill="#f1f5f9" />
            <path d="M540 46H620C629 46 636 39 636 30C636 22 629 15 621 15C617 5 607 -1 595 -1C581 -1 569 10 568 23C553 24 540 34 540 46Z" fill="#f1f5f9" />
            <path d="M940 58H1015C1023 58 1030 51 1030 43C1030 35 1024 29 1016 29C1013 19 1003 13 992 13C978 13 967 23 966 36C952 37 940 46 940 58Z" fill="#f1f5f9" />
          </svg>
        </div>

        {/* Continuous Farm -> Highway -> City Panoramic Background */}
        <div
          className="panorama-track"
          style={{
            transform: `translateX(-${progress * 0.54}%)`,
          }}
        >
          <PanoramicWorldIllustration />
        </div>

        {/* FIXED CENTER PICKUP TRUCK (WHEELS SPINNING + SUSPENSION BOUNCE) */}
        <div className="fixed-center-truck">
          <div className="truck-road-feel">
            <FarmTruckIllustration className="splash-truck-svg" />
          </div>
        </div>

        {/* Fast-Scrolling Asphalt Road & Lane Markings */}
        <div className="journey-road">
          <div className="road-shoulder" />
          <div className="road-dashes-scroll" />
        </div>
      </div>

      {/* Minimal Bottom Progress Indicator */}
      <div className="splash-footer">
        <div className="splash-progress-track">
          <div className="splash-progress-fill" style={{ width: `${progress}%` }} />
        </div>
      </div>
    </div>
  );
}