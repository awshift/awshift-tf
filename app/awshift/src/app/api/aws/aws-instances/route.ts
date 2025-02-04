import { NextRequest, NextResponse } from 'next/server';
import { EC2Client, DescribeInstancesCommand } from '@aws-sdk/client-ec2';

export async function GET(request: NextRequest) {
  try {
    if (!process.env.AWS_REGION || !process.env.AWS_ACCESS_KEY_ID || !process.env.AWS_SECRET_ACCESS_KEY) {
      console.error('❌ Erreur : Variables d’environnement AWS non définies');
      return NextResponse.json(
        { error: 'Configuration AWS manquante' },
        { status: 500 }
      );
    }

    console.log('✅ AWS_REGION:', process.env.AWS_REGION);

    // Initialisation du client EC2
    const ec2Client = new EC2Client({ 
      region: process.env.AWS_REGION,
      credentials: {
        accessKeyId: process.env.AWS_ACCESS_KEY_ID!,
        secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY!
      }
    });

    // Définition de la commande pour récupérer les instances
    const command = new DescribeInstancesCommand({
      Filters: [
        { Name: 'tag:Role', Values: ['master', 'worker'] },
        { Name: 'instance-state-name', Values: ['running'] }
      ]
    });

    // Exécution de la requête
    const response = await ec2Client.send(command);
    
    // Log de la réponse brute AWS pour debug
    console.log('✅ Réponse brute AWS:', JSON.stringify(response, null, 2));

    // Vérification si aucune instance trouvée
    if (!response.Reservations || response.Reservations.length === 0) {
      console.warn('⚠️ Aucune instance trouvée avec les filtres spécifiés.');
      return NextResponse.json(
        { masters: 0, workers: 0, message: 'Aucune instance trouvée.' }
      );
    }

    // Extraction et comptage des instances
    const instances = response.Reservations.flatMap(r => r.Instances ?? []);
    
    const masterInstances = instances.filter(i =>
      i.Tags?.some(tag => tag.Key === 'Role' && tag.Value === 'master')
    ).length;

    const workerInstances = instances.filter(i =>
      i.Tags?.some(tag => tag.Key === 'Role' && tag.Value === 'worker')
    ).length;

    console.log(`🔹 Masters: ${masterInstances}, Workers: ${workerInstances}`);

    return NextResponse.json({ masters: masterInstances, workers: workerInstances });

  } catch (error: any) {
    console.error('❌ Erreur lors de la récupération des instances:', error);
    return NextResponse.json(
      { error: 'Impossible de récupérer les informations des instances', details: error.message },
      { status: 500 }
    );
  }
}
