import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { MessagesService } from '@app/messages/messages.service';
import { MercadoLivreService } from './mercado-livre.service';

@Component({
  selector: 'app-mercado-livre',
  templateUrl: './mercado-livre.component.html',
  styleUrls: ['./mercado-livre.component.scss'],
})
export class MercadoLivreComponent implements OnInit {
  loading = true;
  authUrl: string;
  haveToken = false;
  constructor(
    private router: Router,
    private mercadoLivreService: MercadoLivreService,
    private route: ActivatedRoute,
    private messagesService: MessagesService
  ) {}

  ngOnInit(): void {
    const code = this.route.snapshot.queryParams.code;

    this.verifyToken();

    if (code) {
      this.mercadoLivreService.generateToken(code).subscribe({
        next: () => {
          this.verifyToken();
        },
        error: () => {
          this.messagesService.showError('Não foi possivel gerar o token de autenticação');
        },
      });
    } else {
      this.getAuthUrl();
    }
  }

  getAuthUrl() {
    this.mercadoLivreService.getAuthUrl().subscribe((authUrl) => {
      this.authUrl = authUrl;
      this.loading = false;
    });
  }

  verifyToken() {
    this.mercadoLivreService.getToken().subscribe((token) => {
      if (token) {
        this.haveToken = true;
      } else {
        this.router.navigateByUrl('/mercado-livre');
      }
    });
  }

  redirectToMercadoLivre() {
    window.location.href = this.authUrl;
  }
}
