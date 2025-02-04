'use client';
import React, { useState, useEffect } from 'react';

export default function AwsInfrastructureStatus() {
  const [instanceCounts, setInstanceCounts] = useState({
    masters: 0,
    workers: 0
  });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchInstanceCounts = async () => {
      try {
        const response = await fetch('/api/aws/aws-instances');
        
        if (!response.ok) {
          throw new Error('Échec de la récupération des données');
        }

        const data = await response.json();
        setInstanceCounts(data);
        setLoading(false);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Une erreur est survenue');
        setLoading(false);
      }
    };

    fetchInstanceCounts();
  }, []);

  if (loading) return (
    <div className="bg-primary-50 p-6 rounded-xl shadow-soft animate-pulse flex items-center justify-center">
      <span className="text-primary-500">Chargement...</span>
    </div>
  );

  if (error) return (
    <div className="bg-red-50 text-red-800 p-6 rounded-xl shadow-soft border border-red-200">
      <div className="flex items-center">
        <svg className="w-6 h-6 mr-2 text-red-500" fill="currentColor" viewBox="0 0 20 20">
          <path fillRule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clipRule="evenodd" />
        </svg>
        Erreur : {error}
      </div>
    </div>
  );

  return (
    <div className="bg-background-light p-6 rounded-2xl shadow-medium">
      <h2 className="text-xl font-bold text-primary-800 mb-4">Infrastructure AWS</h2>
      <div className="grid grid-cols-2 gap-4">
        <div className="bg-primary-100 p-4 rounded-xl shadow-soft text-center transition-all hover:scale-105">
          <h3 className="text-lg font-semibold text-primary-700">Masters</h3>
          <p className="text-4xl font-bold text-primary-900">{instanceCounts.masters}</p>
        </div>
        <div className="bg-green-100 p-4 rounded-xl shadow-soft text-center transition-all hover:scale-105">
          <h3 className="text-lg font-semibold text-green-700">Workers</h3>
          <p className="text-4xl font-bold text-green-900">{instanceCounts.workers}</p>
        </div>
      </div>
    </div>
  );
}