import React, { useEffect, useState } from 'react';
import {
  CitySceneIllustration,
  FarmSceneIllustration,
  FarmTruckIllustration,
  SplashVintageTitle,
} from './Illustrations';

export default function SplashScreen({ onFinish }) {
  const [progress, setProgress] = useState(0);
  const [exiting, setExiting] = useState(false);

  useEffect(() => {
    const duration = 3400; // 3.4s smooth farm-to-city drive
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
          setTimeout(onFinish, 420);
        }, 220);
      }
    };

    frameId = requestAnimationFrame(tick);
    return () => cancelAnimationFrame(frameId);
  }, [onFinish]);

  return (
    <div className={`splash-overlay ${exiting ? 'splash-exit' : ''}`}>
      {/* Minimal Arrow Skip Icon Button (No Text) */}
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

      {/* Mobile-App Style Centered Logo + Vintage Farmer's Market Title Only */}
      <div className="splash-center-brand">
        <SplashVintageTitle />
      </div>

      {/* Pure Visual Farm-to-City Truck Animation Stage (Zero Text) */}
      <div className="journey-stage">
        <div className="scenery-farm">
          <FarmSceneIllustration />
        </div>

        <div className="scenery-city">
          <CitySceneIllustration />
        </div>

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

        <div className="journey-road">
          <div className="road-dashes" />
        </div>
      </div>

      {/* Clean Minimal Progress Bar (No Text) */}
      <div className="splash-footer">
        <div className="splash-progress-track">
          <div className="splash-progress-fill" style={{ width: `${progress}%` }} />
        </div>
      </div>
    </div>
  );
}