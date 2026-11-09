import React from 'react';
import { X, MapPin, CheckCircle2 } from 'lucide-react';
import { LOCATIONS } from '../data/mockData';

export default function LocationModal({ currentLocation, setCurrentLocation, onClose }) {
  return (
    <div className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4">
      <div className="bg-white rounded-2xl max-w-md w-full p-6 shadow-2xl border border-slate-100 relative">
        <button 
          onClick={onClose}
          className="absolute top-4 right-4 p-2 text-slate-400 hover:text-slate-600 rounded-full hover:bg-slate-100"
        >
          <X className="w-5 h-5" />
        </button>
        
        <h3 className="text-xl font-extrabold text-slate-900 flex items-center gap-2 mb-1">
          <MapPin className="w-5 h-5 text-emerald-600" />
          Select Delivery Hub
        </h3>
        <p className="text-xs text-slate-500 mb-4">Choose your nearest darkstore location for instant 10-15 min delivery.</p>

        <div className="space-y-2.5">
          {LOCATIONS.map((loc) => {
            const isSelected = currentLocation.id === loc.id;
            return (
              <button
                key={loc.id}
                onClick={() => {
                  setCurrentLocation(loc);
                  onClose();
                }}
                className={`w-full text-left p-3.5 rounded-xl border transition-all flex items-center justify-between ${
                  isSelected 
                    ? 'border-emerald-500 bg-emerald-50/60 shadow-sm' 
                    : 'border-slate-200 hover:border-emerald-200 hover:bg-slate-50'
                }`}
              >
                <div>
                  <div className="font-bold text-sm text-slate-900">{loc.city}</div>
                  <div className="text-xs text-slate-500">{loc.hub}</div>
                </div>
                <div className="flex items-center gap-2">
                  <span className="text-[10px] font-bold bg-emerald-100 text-emerald-800 px-2 py-0.5 rounded-md">
                    {loc.status}
                  </span>
                  {isSelected && <CheckCircle2 className="w-5 h-5 text-emerald-600" />}
                </div>
              </button>
            );
          })}
        </div>
      </div>
    </div>
  );
}