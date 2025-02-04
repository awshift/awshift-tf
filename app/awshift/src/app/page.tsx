import AwsInfrastructureStatus from '@/components/AwsInfrastructureStatus';

export default function Home() {
  return (
    <div className="min-h-screen bg-background-dark flex items-center justify-center p-4">
      <div className="w-full max-w-2xl">
        <h1 className="text-3xl font-bold text-primary-900 mb-6 text-center">
          Dashboard Infrastructure AWS + RKE2
        </h1>
        <AwsInfrastructureStatus />
      </div>
    </div>
  );
}